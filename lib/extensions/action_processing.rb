module Extensions::ActionProcessing
  extend ActiveSupport::Concern

  module ClassMethods
    def default_options
      {
        list_limits: %w(10 20 50 100),
        params_defaults: { limit: 10, page: 0 },
        store_params: %w(group limit page),
        delete_params: %w(limit),
        clean_session_params: %w(group page),
        clean_on_switch: %w(page)
      }
    end

    def acts_as_processing(options = {})
      class_attribute :list_limits
      self.list_limits = options[:list_limits] || default_options[:list_limits]

      # default values for params
      class_attribute :params_defaults
      self.params_defaults = options[:params_defaults] || default_options[:params_defaults]

      # store these params in session
      class_attribute :store_params
      self.store_params = options[:store_params] || default_options[:store_params]

      # explicitly delete these params
      class_attribute :delete_params
      self.delete_params = options[:delete_params] || default_options[:delete_params]

      # delete the session data when corresponding params are empty
      class_attribute :clean_session_params
      self.clean_session_params = options[:clean_session_params] || default_options[:clean_session_params]

      # clean these attributes if switching appears
      class_attribute :clean_on_switch
      self.clean_on_switch = options[:clean_on_switch] || default_options[:clean_on_switch]
    end
  end

  # store incoming params to session, delete session data if params empty, delete params from links
  def store_and_process_params
    # default session data
    s_key = params[:controller].gsub(/\//, '_').to_sym
    session[s_key] ||= params_defaults

    # store params in session
    s_params = params.select { |k, _v| store_params.include? k.to_s }
    s_del = clean_session_params
    if s_params.any?
      s_params.each { |k, v| session[s_key][k.to_sym] = v }
      s_del += clean_on_switch
    end

    # explicitly delete these params to prevent their appearance in pagination links
    params.delete_if { |k, _v| delete_params.include? k.to_s }

    # we have to delete the session data when corresponding params are empty
    s_del.each { |k| session[s_key].delete(k.to_sym) unless params[k.to_sym] }
  end
end
