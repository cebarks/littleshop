class Order < ApplicationRecord
  validates_presence_of :status
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  enum status: %w(pending complete cancelled unknown)

  def self.top_3_biggest_orders
    joins(:items)
    .group("orders.id")
    .order("size DESC")
    .where("orders.status": 1)
    .select("orders.*, sum(order_items.quantity) as size")
    .limit(3)
  end

  def grand_total
    OrderItem.where(order: self).sum("price * quantity")
  end

  def total_quantity
    OrderItem.where(order: self).sum(:quantity)
  end

  def cancel_all(order)
    OrderItem.all.map do |order_item|
      order_item.cancel_order_item(order)
      order_item.return_quantity(order)
      order[:status] = "cancelled"
    end
  end

  def total_price_by_merchant(merchant)
    OrderItem.joins(:item).where(order: self).where("items.user_id": merchant).sum("order_items.price * quantity")
  end

  def total_quantity_by_merchant(merchant)
    OrderItem.joins(:item).where(order: self).where("items.user_id": merchant).sum(:quantity)
  end

  def completely_fulfilled?
    items_belonging_to_this_order = OrderItem.where(order: self) #gives us all of this order's items
    booleans = items_belonging_to_this_order.map do |oi|
      oi.fulfillment
    end
    unless booleans.include?(false)
      true
    else
      false
    end
  end

end
