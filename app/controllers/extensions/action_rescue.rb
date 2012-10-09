module Extensions::ActionRescue
  extend ActiveSupport::Concern

  def self.included(base)
    base.class_eval do
      # stop if access error raised
      rescue_from CanCan::AccessDenied do |e|
        alert = t("alerts.#{e.subject.class.name.underscore}.#{e.action}", default: t('alerts.access_denied'))

        if current_user
          # ajax response
          if request.xhr?
            render(js: "alert('#{alert}');")
          else
            flash[:alert] = alert
            redirect_to(root_url)
          end
        else
          # ajax response
          if request.xhr?
            render js: "alert('#{t("devise.failure.timeout")}')"
          else
            flash[:alert] = alert
            # store current location to return here after login
            store_location!
            redirect_to new_user_session_url
          end
        end
      end
    end
  end
end
