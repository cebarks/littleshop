class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zipcode, :email, :password_digest
  validates_uniqueness_of :email
  validates_numericality_of :zipcode
  has_many :items

  has_secure_password
  enum role: ["default", "merchant", "admin"]

  def self.merchants
    where(role: 1)
  end

  def active_items
    items.where(status: true)
  end
end
