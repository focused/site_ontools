class ApplicationController < ActionController::Base
  protect_from_forgery

  # for lists (#index action)
  cattr_reader :list_limits
  @@list_limits = %w(10 20 50 100)

  # default values for params
  cattr_accessor :params_defaults
  @@params_defaults = { limit: 10 }

  # store these params in session
  cattr_accessor :store_params
  @@store_params = %w(group limit page)

  # explicitly delete these params
  cattr_accessor :delete_params
  @@delete_params = %w(limit)

  # delete the session data when corresponding params are empty
  cattr_accessor :clean_session_params
  @@clean_session_params = %w(group page)

  # stop if access error raised
  rescue_from CanCan::AccessDenied do |e|
    flash[:alert] = t 'alerts.access_denied'

    if current_user
      # ajax response
      request.xhr? ? render(js: "alert('#{t("devise.failure.timeout")}');") : redirect_to(root_url)
    else
      # ajax response
      if request.xhr?
        render js: "alert('#{t("devise.failure.timeout")}');"
      else
        # store current location to return here after login
        store_location!
        redirect_to new_user_session_url
      end
    end
  end

  # set default meta tags
  before_filter :meta_tags

  # make menu lists for using accross the whole layout
  before_filter :make_menu_lists

  protected

  def meta_tags
    # meta = PageMetaTag.by_path(params[:path].to_s)

    # set_meta_tags(
    #   title: (meta.try(:title).present? and !meta.title.nil?) ? meta.title.to_str : t.meta.title,
    #   description: (meta.try(:description).present? and !meta.description.nil?) ? meta.description.to_str : t.meta.description,
    #   keywords: (meta.try(:keywords).present? and !meta.keywords.nil?) ? meta.keywords.to_str : t.meta.keywords
    # )
  end

  def make_menu_lists
    @menu_lists = {
      # news_groups: NewsGroup.ordered.all
    }
  end

  private

  # store incoming params to session, delete session data if params empty, delete params from links
  def store_and_process_params
    # default session data
    s_key = params[:controller].to_sym
    session[s_key] ||= @@params_defaults
    # store params in session
    params.select { |k, _v| @@store_params.include? k.to_s }.each { |k, v| session[s_key][k.to_sym] = v }
    # explicitly delete these params to prevent their appearance in pagination links
    params.delete_if { |k, _v| @@delete_params.include? k.to_s }
    # we have to delete the session data when corresponding params are empty
    @@clean_session_params.each { |k| session[s_key].delete(k.to_sym) unless params[k.to_sym] }
  end

  # adds language prefix to every url unless locale is native
  def default_url_options
    { locale: r18n.locale.code == APP[:native_locale] || Rails.env.test? ? nil : r18n.locale.code }
  end

  # last visited location, stored for future redirect after signing in
  def store_location!
    session["user_return_to"] = request.xhr? ? root_url : request.fullpath
  end

  # 404 handler for pages
  def not_found
    render file: '/not_found', status: 404
  end
end
