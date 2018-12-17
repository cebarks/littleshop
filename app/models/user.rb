class User < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode
  validates_presence_of :email
  has_many :items

  def self.merchants
    where(role: 1)
  end

  def active_items
    items.where(status: true)
  end

end
