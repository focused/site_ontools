class FastOrdersController < ApplicationController
  layout false

  def new
    @fast_order = FastOrder.new(product_id: params[:product_id])
    render :_form
  end

  def create
    @fast_order = FastOrder.new(params[:fast_order])
    if @fast_order.save
      NotifyMailer.fast_order(@fast_order)
    else
      render :new
    end
  end
end
