class FastOrder < ActiveRecord::Base
  attr_accessible :name, :phone, :email

  scope :ordered, order { fast_orders.created_at.desc }

  validates :name, :phone, :email, presence: true
  validates :email, format: /.+@.+\..+/i
end
