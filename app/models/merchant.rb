class Merchant < ApplicationRecord
  validates_presence_of :name, :city, :state
  has_many :items

  def active_items
    items.where(status: :true)
  end
end
