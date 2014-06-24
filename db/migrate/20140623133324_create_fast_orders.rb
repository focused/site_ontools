class CreateFastOrders < ActiveRecord::Migration
  def change
    create_table :fast_orders do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.integer :status

      t.timestamps
    end
  end
end
