class ProductGroupsController < ApplicationController
  respond_to :html

  def show
    @product_group = ProductGroup.includes(children: { products: 'images' })
      .ordered.find(params[:id])
  end
end
