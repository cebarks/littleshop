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
    .where("orders.status=1")
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

end
