class Backend::ProductGroupsController < Backend::ApplicationController
  respond_to :html

  load_and_authorize_resource

  acts_as_processing({ store_params: %w(limit page), clean_session_params: %w(),
    params_defaults: { limit: 10 } })

  def index
    @product_groups = @product_groups.ordered.page(session[:backend_product_groups][:page])
      .per(session[:backend_product_groups][:limit])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    redirect_to [:backend, @product_group], notice: t('was.created') and return if @product_group.save
    respond_with(@product_group)
  end

  def update
    if @product_group.update_attributes(params[:product_group])
      redirect_to [:backend, @product_group], notice: t('was.updated') and return
    end
    respond_with(@product_group)
  end

  def destroy
    @product_group.destroy
    flash[:notice] = t 'was.destroyed'
    respond_with(@product_group, location: backend_product_groups_path)
  end
end
