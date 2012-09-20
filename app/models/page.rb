class Page < ActiveRecord::Base
  include R18n::Translated

  before_save do
    self.path = "/#{path}" if path[/^\//].nil?
  end

  has_one :page_meta_tag, inverse_of: :page, dependent: :destroy

  attr_accessible :path, :title_en, :title_ru, :title_az, :content_en, :content_ru, :content_az, :visible

  translations :title, :content

  scope :ordered, order { pages.created_at.desc }
  scope :visible, where(visible: true)
  scope :published, visible.ordered

  validates :path, presence: true, uniqueness: true

  def self.by_path(path)
    return self.scoped unless path
    self.where("path=:path", path: "/" + path.gsub(/^\/+/, '')).first
  end

  def self.search(params)
    search = self.scoped
    return search unless params
    params.reject! { |_k, v| v.blank? }

    search = search.where { path =~ "%#{params[:path]}%" } if params[:path]
    search = search.where { title =~ "%#{params[:title]}%" } if params[:title]

    search
  end
end
