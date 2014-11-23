class Backend::ProductsController < Backend::ApplicationController
  respond_to :html

  load_and_authorize_resource

  before_action only: %w(new edit) do
    @product.images.build if @product.images.empty?
  end

  acts_as_processing({ store_params: %w(limit page), clean_session_params: %w(),
    params_defaults: { limit: 10 } })

  def index
    @products = @products.ordered.page(session[:backend_products][:page])
      .per(session[:backend_products][:limit])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    redirect_to [:backend, @product], notice: t('was.created') and return if @product.save
    respond_with(@product)
  end

  def update
    if @product.update_attributes(params[:product])
      redirect_to [:backend, @product], notice: t('was.updated') and return
    end
    respond_with(@product)
  end

  def destroy
    @product.destroy
    flash[:notice] = t 'was.destroyed'
    respond_with(@product, location: backend_products_path)
  end
end
