# Adds params and session routine for grouping, pagination, limiting, etc. for
# action :index. Other actions initialize empty session, otherwise error could
# occur when session[:session_key] is nil.
#
# Examples:
#
#   class ArticlesController < ApplicationController
#     acts_as_processing
#     ...
#
#   class NewsController < ApplicationController
#     acts_as_processing({ list_limits: %w(10 20 40 80), session_key: :events })
#
#     def index
#       @news = News.includes(:news_group).in_group(params[:group])
#         .search_any(params[:news]).page(params[:page])
#         .per(session[:news][:limit])
#     end
#
#   In view:
#     controller.list_limits.each do |n|
#     ...
#
module Extensions::ActionProcessing
  extend ActiveSupport::Concern

  module ClassMethods
    def default_options
      {
        list_limits: %w(10 20 50 100),
        params_defaults: { limit: 10 },
        store_params: %w(group limit page),
        delete_params: %w(limit),
        clean_session_params: %w(group page),
        clean_on_switch: %w(page),
        session_key: nil,
        process_actions: 'index',
        init_actions: nil
      }
    end

    def acts_as_processing(options = {})
      options.reverse_merge!(default_options)

      class_attribute :list_limits
      self.list_limits = options[:list_limits]

      # default values for params
      class_attribute :params_defaults
      self.params_defaults = options[:params_defaults]

      # store these params in session
      class_attribute :store_params
      self.store_params = options[:store_params]

      # explicitly delete these params
      class_attribute :delete_params
      self.delete_params = options[:delete_params]

      # delete the session data when corresponding params are empty
      class_attribute :clean_session_params
      self.clean_session_params = options[:clean_session_params]

      # clean these attributes if switching appears
      class_attribute :clean_on_switch
      self.clean_on_switch = options[:clean_on_switch]

      class_attribute :session_key
      self.session_key = options[:session_key]
      self.session_key = controller_path.gsub(/\//, '_').to_sym if session_key.blank?

      # declare store and process filter only for these actions
      class_attribute :process_actions
      self.process_actions = options[:process_actions]

      # declare init filter only for these actions
      class_attribute :init_actions
      self.init_actions = options[:init_actions]

      # register filters
      before_filter(init_actions ? { only: init_actions } : {}) do
        session[session_key] ||= params_defaults # default session data
      end
      before_filter :store_and_process_params, only: process_actions

    end
  end

  # store incoming params to session, delete session data if params empty, delete params from links
  def store_and_process_params
    # store params in session
    s_params = params.select { |k, _v| store_params.include? k.to_s }
    s_del = clean_session_params
    if s_params.any?
      s_params.each { |k, v| session[session_key][k.to_sym] = v }
      s_del += clean_on_switch
    end

    # explicitly delete these params to prevent their appearance in pagination links
    params.delete_if { |k, _v| delete_params.include? k.to_s }

    # we have to delete the session data when corresponding params are empty
    s_del.each { |k| session[session_key].delete(k.to_sym) unless params[k.to_sym] }
  end
end
