class AddProductIdToFastOrders < ActiveRecord::Migration
  def change
    add_column :fast_orders, :product_id, :integer
  end
end
