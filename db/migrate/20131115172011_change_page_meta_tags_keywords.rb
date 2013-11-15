class ChangePageMetaTagsKeywords < ActiveRecord::Migration
  def up
    change_column :page_meta_tags, :keywords_ru, :text
    change_column :page_meta_tags, :keywords_en, :text
  end

  def down
    change_column :page_meta_tags, :keywords_ru, :string
    change_column :page_meta_tags, :keywords_en, :string
  end
end
