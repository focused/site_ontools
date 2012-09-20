class Backend::AppPagesController < Backend::ApplicationController
  respond_to :html

  authorize_resource class: false

  def index

  end

end
