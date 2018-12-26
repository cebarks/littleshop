class Order < ApplicationRecord
  validates_presence_of :status
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  def self.top_3_biggest_orders
    joins(:items)
    .group("orders.id")
    .order("size DESC")
    .where("orders.status=1")
    .select("orders.*, sum(order_items.quantity) as size")
    .limit(3)
  end

end
