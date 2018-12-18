class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zipcode, :email, :password
  validates_uniqueness_of :email
  has_many :items

  def self.merchants
    where(role: 1)
  end

  def active_items
    items.where(status: true)
  end
end
