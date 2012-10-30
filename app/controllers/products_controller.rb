class ProductsController < ApplicationController
  respond_to :html

  def show
    @product = Product.includes(:images).find(params[:id])
  end

end
