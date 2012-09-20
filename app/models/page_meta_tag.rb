class PageMetaTag < ActiveRecord::Base
  include R18n::Translated

  before_save do
    self.path = "/#{path}" if path[/^\//].nil?
  end

  belongs_to :page, inverse_of: :page_meta_tag

  attr_accessible :path, :power, :title_ru, :title_en, :title_az,
    :description_ru, :description_en, :description_az,
    :keywords_ru, :keywords_en, :keywords_az

  translations :title, :description, :keywords

  scope :ordered, order { path }

  validates :path, presence: true

  def self.by_path(path)
    path = path.present? ? "/" + path.gsub(/^\/+/, '') + "%" : "/"
    self.where("path ILIKE :path", path: path).ordered.first
  end

end
