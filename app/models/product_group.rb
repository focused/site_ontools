require 'validators/file_size_validator'

class ProductGroup < ActiveRecord::Base
  attr_accessible :name, :position, :visible, :alias_name, :description, :parent_id
  attr_accessible :image, :image_cache, :remove_image

  after_destroy :clear_files

  has_many :products
  has_many :children, foreign_key: 'parent_id', class_name: 'ProductGroup', :dependent => :destroy
  belongs_to :parent, class_name: 'ProductGroup'

  mount_uploader :image, ProductGroupUploader

  scope :ordered, order { [parent_id.desc, position] }
  scope :root, where(parent_id: nil)
  scope :in_group, lambda { |id| where(parent_id: id) }

  validates :name, presence: true, length: { maximum: 500 }
  validates :alias_name, presence: true, uniqueness: true, length: { maximum: 255 }
  # 3 MB file
  validates :image, file_size: { maximum: 3.megabytes.to_i }, if: lambda { |o| o.image_cache.blank? }

  def to_s
    name
  end

  private

  # delete attached file and its versions if present
  def clear_files
    FileUtils.rm_rf(File.dirname(self.image.current_path)) unless self.image.current_path.nil?
  end
end
