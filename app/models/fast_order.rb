class FastOrder < ActiveRecord::Base
  attr_accessible :name, :phone, :email, :product_id

  belongs_to :product

  scope :ordered, order { fast_orders.created_at.desc }

  validates :name, :phone, :email, presence: true
  validates :email, format: /.+@.+\..+/i

  def product_name
    product.try :name
  end
end
