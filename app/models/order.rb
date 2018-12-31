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

  def total_price_by_merchant(merchant)
    OrderItem.joins(:item).where(order: self).where("items.user_id": merchant).sum("order_items.price * quantity")
  end

  def total_quantity_by_merchant(merchant)
    OrderItem.joins(:item).where(order: self).where("items.user_id": merchant).sum(:quantity)
  end
end
