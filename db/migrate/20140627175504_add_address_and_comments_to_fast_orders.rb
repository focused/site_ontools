class AddAddressAndCommentsToFastOrders < ActiveRecord::Migration
  def change
    add_column :fast_orders, :address, :text
    add_column :fast_orders, :comments, :text
  end
end
