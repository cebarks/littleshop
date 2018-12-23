class Item < ApplicationRecord
  validates_presence_of :name, :description, :inventory_qty, :price, :user
  validates_inclusion_of :status, :in => [true, false]
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items

  def self.top_five_by_popularity
    Item.joins(:order_items, :orders)
        .group(:id)
        .order("amount_sold DESC")
        .where("orders.status = 1")
        .select("items.*, sum(order_items.quantity) as amount_sold")
        .limit(5)
  end

  def self.bottom_five_by_popularity
    Item.joins(:order_items, :orders)
        .group(:id)
        .order("amount_sold ASC")
        .where("orders.status = 1")
        .select("items.*, sum(order_items.quantity) as amount_sold")
        .limit(5)
  end
  
  def average_fulfillment_time
    time = Item.joins(:order_items, :orders)
    .select("avg(orders.updated_at - orders.created_at) as avg_fulfill").group(:id)
    .where("items.id": id).first.avg_fulfill
    days =  time[0..1].strip.to_i + (time.split("days").last.split(":").first.strip.to_i / 24.to_f).round(2)
    days
  end
end
