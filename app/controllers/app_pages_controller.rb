class AppPagesController < ApplicationController
  respond_to :html
  layout false, only: 'home_stub'

  def home
    @product_groups = ProductGroup.roots.ordered
  end

  def home_stub
  end

  def prices
    @products = Product.ordered.all

    respond_with do |f|
      f.xml { @product_groups = ProductGroup.ordered.all }
    end
  end
end
