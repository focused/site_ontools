class Backend::PageMetaTagsController < Backend::ApplicationController
  respond_to :html

  load_and_authorize_resource

  def index
    @page_meta_tags = @page_meta_tags.ordered.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    redirect_to [:backend, @page_meta_tag], notice: t('was.created') and return if @page_meta_tag.save
    respond_with(@page_meta_tag)
  end

  def update
     if @page_meta_tag.update_attributes(params[:page_meta_tag])
      redirect_to [:backend, @page_meta_tag], notice: t('was.updated') and return
    end
    respond_with(@page_meta_tag)
  end

  def destroy
    @page_meta_tag.destroy
    flash[:notice] = t 'was.destroyed'
    respond_with(@page_meta_tag, location: backend_page_meta_tags_path)
  end
end
