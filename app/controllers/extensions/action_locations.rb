module Extensions::ActionLocations
  extend ActiveSupport::Concern

  protected
  # last visited location, stored for future redirect after signing in
  def store_location!
    session["user_return_to"] = request.xhr? ? root_url : request.fullpath
  end

  # 404 handler for pages
  def not_found
    render file: '/not_found', status: 404
  end
end

