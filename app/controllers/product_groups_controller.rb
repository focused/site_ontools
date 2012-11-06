class ProductGroupsController < ApplicationController
  respond_to :html

  def show
    @product_group = ProductGroup.find(params[:id])
  end
end
