class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :path
      t.string :title_ru, limit: 500
      t.string :title_en, limit: 500
      t.text :content_ru
      t.text :content_en
      t.boolean :visible, default: true

      t.timestamps
    end
  end
end
