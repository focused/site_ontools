class Product < ActiveRecord::Base
  attr_accessible :alias_name, :description, :name, :position, :price, :price,
    :structure, :visible, :product_group_id, :images_attributes

  belongs_to :product_group
  after_initialize do
    Image.image_sizes = {
      full: [800, 800],
      normal: [160, 160],
      mini: [50, 50]
    }
  end

  has_many :images, as: 'owner', dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true

  scope :ordered, order { [product_group_id != nil, product_group_id, position] }
  scope :visible, where(visible: true)

  validates :name, presence: true, length: { maximum: 512 }
  validates :alias_name, presence: true, uniqueness: true, length: { maximum: 512 }, format: { with: /^[-a-z_]+$/i }

  def to_s
    name
  end

  def to_param
    "#{id}-#{alias_name}"
  end

  def intro
    if par1 = content[/(<p>(.+?)<\/p>|([^>\n]+))/m, 0]
      par1.strip
    else
      content
    end
  end
end
