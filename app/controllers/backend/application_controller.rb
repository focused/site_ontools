class Backend::ApplicationController < ActionController::Base
  protect_from_forgery

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

  private

  # last visited location, stored for future redirect after signing in
  def store_location!
    session["user_return_to"] = request.xhr? ? root_url : request.fullpath
  end

  # 404 handler for pages
  def not_found
    render file: '/not_found', status: 404
  end
end
