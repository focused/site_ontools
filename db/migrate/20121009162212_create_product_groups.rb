class CreateProductGroups < ActiveRecord::Migration
  def change
    create_table :product_groups do |t|
      t.string :name
      t.integer :position, default: 0, null: false
      t.boolean :visible, default: true
      t.string :alias_name
      t.text :description
      t.integer :parent_id
      t.string :image, limit: 500

      t.timestamps
    end

    add_index :product_groups, :alias_name, :unique
  end
end
