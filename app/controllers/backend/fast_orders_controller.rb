class Backend::FastOrdersController < Backend::ApplicationController
  respond_to :html

  load_and_authorize_resource

  acts_as_processing({ store_params: %w(limit page), clean_session_params: %w(),
    params_defaults: { limit: 10 } })

  def index
    @fast_orders = @fast_orders.ordered.page(session[:backend_fast_orders][:page])
      .per(session[:backend_fast_orders][:limit])
  end

  def show
  end

  # def new
  # end

  # def edit
  # end

  # def create
  #   redirect_to [:backend, @fast_order], notice: t('was.created') and return if @fast_order.save
  #   respond_with(@fast_order)
  # end

  # def update
  #    if @fast_order.update_attributes(params[:fast_order])
  #     redirect_to [:backend, @fast_order], notice: t('was.updated') and return
  #   end
  #   respond_with(@fast_order)
  # end

  # def destroy
  #   @fast_order.destroy
  #   flash[:notice] = t 'was.destroyed'
  #   respond_with(@fast_order, location: backend_fast_orders_path)
  # end
end
