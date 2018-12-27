class OrderItem < ApplicationRecord
  validates_presence_of :order, :item, :price, :quantity
  belongs_to :order
  belongs_to :item

  def subtotal
    price * quantity
  end
end
