class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zipcode, :email, :password_digest
  validates_uniqueness_of :email
  validates_numericality_of :zipcode
  has_many :items
  has_many :orders

  has_secure_password
  enum role: ["default", "merchant", "admin"]

  def self.merchants
    where(role: 1)
  end

  def active_items
    items.where(status: true)
  end

  def self.enabled_merchants
    merchants.where(status: true)
  end

  def self.default_users
    where(role: 0)
  end

  def self.top_3_merchants_by_items_sold
    Item.joins(:user)
    .joins(:orders)
    .group("users.id")
    .order("items_sold DESC")
    .select("users.*, sum(order_items.quantity) as items_sold")
    .limit(3)
  end

  def self.top_3_merchants_by_profit
    Item.joins(:user)
    .joins(:orders)
    .group("users.id")
    .order("earnings DESC")
    .select("users.*, sum(order_items.price) as earnings")
    .limit(3)
  end

  def self.top_3_merchants_by_fulfillment_speed
    Item.joins(:user)
    .joins(:orders)
    .group("users.id")
    .order("speed ASC")
    .select("users.*, avg(orders.updated_at - orders.created_at) as speed")
    .limit(3)
  end

  def self.bottom_3_merchants_by_fulfillment_speed
    Item.joins(:user)
    .joins(:orders)
    .group("users.id")
    .order("speed DESC")
    .select("users.*, avg(orders.updated_at - orders.created_at) as speed")
    .limit(3)
  end

  def self.top_3_states_by_order_count
    joins(:orders)
    .group("users.id")
    .order("order_count DESC")
    .where("orders.status = 1")
    .select("users.state, count(orders.id) as order_count")
    .limit(3)
  end

  def fulfillment_speed
    Item.joins(:user)
    .joins(:orders)
    .group("users.id")
    .select("users.*")
    .where("users.id = #{id}")
    .average("orders.updated_at - orders.created_at")
    .values[0].to_i
  end

  def earnings
    User.find(id)
    .items
    .joins(:orders)
    .group("order_items.id")
    .where("orders.status = 1")
    .select("order_items.*")
    .sum("order_items.price")
    .values[0]
  end

  def items_sold
    User.find(id)
    .items
    .joins(:orders)
    .group("order_items.id")
    .where("orders.status = 1")
    .select("order_items.*")
    .sum("order_items.quantity")
    .values[0]
  end

end
