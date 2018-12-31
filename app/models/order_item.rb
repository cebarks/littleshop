class OrderItem < ApplicationRecord
  validates_presence_of :order, :item, :price, :quantity
  belongs_to :order
  belongs_to :item

  def subtotal
    price * quantity
  end

  def cancel_order_item
    self[:fulfillment] = false
    self.save
    self
  end

  def return_quantity
    item = Item.find(self.item_id)
    inventory = self[:quantity]
    item.add_inventory(inventory)
    self[:quantity] -= inventory
    self.save
    self
  end
end
