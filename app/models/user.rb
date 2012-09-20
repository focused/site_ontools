require 'valid_email'

class User < ActiveRecord::Base
  # roles_mask can have corresponding values: 1, 2, 4
  ROLES = %w(admin manager editor)

  attr_accessor :do_confirm
  @do_confirm = false

  attr_accessor :edited_by_admin
  @edited_by_admin = false

  # Include default devise modules. Others available are:
  # :token_authenticatable, :validatable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  attr_accessible :first_name, :middle_name, :last_name, :location_attributes
  attr_accessible :roles_mask, as: 'admin'

  before_create { self.roles = %w(admin) unless User.any? || roles.any? } # set admin role for the first user
  after_create { self.confirm! if do_confirm }

  scope :ordered, order { users.email }

  validates :email, presence: true, email: { mx: Rails.env == 'production' ? true : false }, uniqueness: true
  validates :password, length: { minimum: 6, maximum: 64 }, allow_blank: true
  validates_presence_of :password, unless: 'edited_by_admin'
  validates_confirmation_of :password

  # override devise method to prevent current_password validation when edited by admin
  def update_with_password(params, *options)
    if edited_by_admin && !params.key?(:current_password)
      if params[:password].blank?
        params.delete(:password)
        params.delete(:password_confirmation) if params[:password_confirmation].blank?
      end

      update_attributes(params, *options)
    else
      super
    end
  end

  # set roles array
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2 ** ROLES.index(r) }.sum
  end

  # get roles array
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2 ** ROLES.index(r)).zero? }
  end

  def add_role(role)
    self.roles = (roles << role.to_s)
    save
  end

  # if user has the roles
  def is?(role_or_roles)
    role_or_roles.is_a?(Array) ? (roles & role_or_roles).any? : roles.include?(role_or_roles.to_s)
  end
end
