class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file, limit: 500
      t.string :name, limit: 500
      t.integer :file_size
      t.string :content_type
      t.references :owner, polymorphic: true

      t.timestamps
    end
    add_index :images, [:owner_type, :owner_id]
  end
end
