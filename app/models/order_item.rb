class OrderItem < ApplicationRecord
  validates_presence_of :order, :item, :price
  belongs_to :order
  belongs_to :item
end
