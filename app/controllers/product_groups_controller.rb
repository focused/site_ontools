class ProductGroupsController < ApplicationController
  respond_to :html

  def show
    @product_group = ProductGroup.find(params[:id])
    @products = @product_group.products.ordered.includes(:images).all
  end
end
