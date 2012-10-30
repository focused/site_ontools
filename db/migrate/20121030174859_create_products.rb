class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, limit: 512
      t.string :alias_name, limit: 512
      t.text :description
      t.text :structure
      t.decimal :price, precision: 8, scale: 2, default: 0, null: true
      t.integer :position, default: 0, null: false
      t.boolean :visible, default: true
      t.references :product_group
    end
    add_index :products, :alias_name, unique: true
    add_index :products, :product_group_id
  end
end
