class AddContentToProductGroups < ActiveRecord::Migration
  def change
    add_column :product_groups, :content, :text
  end
end
