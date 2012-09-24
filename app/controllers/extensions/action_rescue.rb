module Extensions::ActionRescue
  extend ActiveSupport::Concern

  def self.included(base)
    base.class_eval do
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
    end
  end
end
