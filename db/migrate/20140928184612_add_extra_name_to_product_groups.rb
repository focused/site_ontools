class AddExtraNameToProductGroups < ActiveRecord::Migration
  def change
    add_column :product_groups, :extra_name, :string
  end
end
