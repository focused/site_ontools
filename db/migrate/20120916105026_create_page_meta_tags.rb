class CreatePageMetaTags < ActiveRecord::Migration
  def change
    create_table :page_meta_tags do |t|
      t.string :path, limit: 500
      t.references :page

      t.string :title_ru, length: { maximum: 600 }
      t.string :title_en, length: { maximum: 600 }
      t.string :description_ru, length: { maximum: 600 }
      t.string :description_en, length: { maximum: 600 }
      t.string :keywords_ru, length: { maximum: 600 }
      t.string :keywords_en, length: { maximum: 600 }

      t.timestamps
    end
  end
end
