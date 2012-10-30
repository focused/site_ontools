require 'validators/file_size_validator'

class ProductGroup < ActiveRecord::Base
  attr_accessible :name, :position, :visible, :alias_name, :description, :parent_id
  attr_accessible :image, :image_cache, :remove_image

  after_destroy :clear_files

  has_many :products, dependent: :nullify
  has_many :children, foreign_key: 'parent_id', class_name: 'ProductGroup', dependent: :destroy
  belongs_to :parent, class_name: 'ProductGroup'

  mount_uploader :image, ProductGroupUploader

  scope :ordered, order { [parent_id != nil, parent_id, position] }
  scope :roots, where(parent_id: nil)
  scope :in_group, proc { |id| where(parent_id: id) }

  validates :name, presence: true, length: { maximum: 255 }
  validates :alias_name, presence: true, uniqueness: true, length: { maximum: 255 }
  # 3 MB file
  validates :image, file_size: { maximum: 3.megabytes.to_i }, if: lambda { |o| o.image_cache.blank? }

  # def self.indexed_tree
  #   tree = {}
  #   ordered.values_of(:id, :name, :alias_name, :parent_id).each do |id, name, alias_name, parent_id|
  #     if parent_id.blank?
  #       tree[id.to_s] = { name: name, path: "/product_groups/#{id}-#{alias_name}", children: [] }
  #     else
  #       tree[parent_id.to_s][:children] << { name: name, path: "#{tree[parent_id.to_s][:path]}##{alias_name}" }
  #     end
  #   end
  #   tree
  # end

  def self.indexed_tree
    tree = {}
    ordered.includes(:products).select(%w(id name alias_name parent_id)).each do |item|
      if item.parent_id.blank?
        tree[item.id.to_s] = { name: item.name, path: "/product_groups/#{item.to_param}",
          children: [], products: item.products }
      else
        tree[item.parent_id.to_s][:children] << { name: item.name,
          path: "#{tree[item.parent_id.to_s][:path]}##{item.alias_name}", products: item.products }
      end
    end
    tree
  end

  def to_s
    name
  end

  def to_param
    "#{id}-#{alias_name}"
  end

  private

  # delete attached file and its versions if present
  def clear_files
    FileUtils.rm_rf(File.dirname(self.image.current_path)) unless self.image.current_path.nil?
  end
end
