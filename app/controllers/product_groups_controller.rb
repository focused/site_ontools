class ProductGroupsController < ApplicationController
  respond_to :html

  def show
    @product_group = ProductGroup.find(params[:id])
    @product_groups = ProductGroup.where(parent_id: @product_group)
  end
end
