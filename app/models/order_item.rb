class OrderItem < ApplicationRecord
  validates_presence_of :order, :item, :price, :quantity
  belongs_to :order
  belongs_to :item

  def subtotal
    price * quantity
  end

  def cancel_order_item(order)
    order = Order.find(order.id)
    order.order_items.map do |order_item|
      order_item[:fulfillment] = false
      order_item.save
    end
  end

  def return_quantity(order)
    order = Order.find(order.id)
    final = []
    order.order_items.each do |order_item|
      inventory = order_item[:quantity]
      item = Item.find(order_item.item_id)
      order_item[:quantity] -= inventory
      item.add_inventory(inventory)
      order_item.save
      final << order_item
    end
    final
  end
end
