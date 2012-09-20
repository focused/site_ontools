class Backend::PagesController < Backend::ApplicationController
  respond_to :html

  load_and_authorize_resource

  def index
    @pages = @pages.search(params[:search]).ordered.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    redirect_to [:backend, @page], notice: t('was.created') and return if @page.save
    respond_with(@page)
  end

  def update
    if @page.update_attributes(params[:page])
      redirect_to [:backend, @page], notice: t('was.updated') and return
    end
    respond_with(@page)
  end

  def destroy
    @page.destroy
    flash[:notice] = t 'was.destroyed'
    respond_with(@page, location: backend_pages_path)
  end
end
