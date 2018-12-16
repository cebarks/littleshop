class Merchant < ApplicationRecord
  has_many :items

  def active_items
    items.where(status: :true)
  end
  
end
