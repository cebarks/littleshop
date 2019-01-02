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
    .order("fulfillment_speed ASC")
    .select("users.*, avg(orders.updated_at - orders.created_at) as fulfillment_speed")
    .limit(3)
  end

  def self.bottom_3_merchants_by_fulfillment_speed
    Item.joins(:user)
    .joins(:orders)
    .group("users.id")
    .order("fulfillment_speed DESC")
    .select("users.*, avg(orders.updated_at - orders.created_at) as fulfillment_speed")
    .limit(3)
  end

  def self.top_3_states_by_order_count
    joins(:orders)
    .group("users.id")
    .order("order_count DESC")
    .where("orders.status = 1 and users.status = true")
    .select("users.*, count(orders.id) as order_count")
    .limit(3)
  end

  def self.top_3_cities_by_order_count
    joins(:orders)
    .group("users.id")
    .order("order_count DESC")
    .where("orders.status = 1 and users.status = true")
    .select("users.*, count(orders.id) as order_count")
    .limit(3)
  end

  def toggle_status
    self[:status] = !self[:status]
  end

  def enabled?
    status
  end

  def items_sold
    Item.joins(:order_items).where(user: self).sum('order_items.quantity')
  end

  def items_sold_percentage
    total_stock = Item.where(user: self).sum(:inventory_qty)
    items_sold / total_stock.to_f
  end

  def top_5_items
    Item.joins(:order_items)
    .where(user: self)
    .select("items.*")
    .select('sum(order_items.quantity) as total_sold')
    .group('items.id')
    .order('total_sold DESC')
    .limit(5)
    .to_ary
  end

  def top_3_states
    Order.joins(:user, :items)
    .select('count(users.state) as state_count, users.state')
    .where('items.user': self)
    .order('state_count ASC')
    .group('users.state')
    .group('users.id')
    .limit(3)
    .map(&:state)
  end

  def top_3_city_states
    Order.joins(:user, :items)
    .select("concat(users.city, ', ' , users.state) as city_state , users.state, users.city")
    .select("count(concat(users.city, ', ' , users.state)) as city_state_count")
    .where('items.user': self)
    .order('city_state_count ASC')
    .group('users.city')
    .group('users.id')
    .limit(3)
    .map(&:city_state)
  end

  def top_customer_by_order_count
    order = Order.joins(:user, :items)
    .where('items.user': self)
    .select("count(user) as order_count")
    .select("user_id")
    .group('user_id')
    .order('order_count DESC')
    .limit(1).first

    if order
      order.user.name
    else
      "n/a"
    end
  end

  def top_customer_by_quantity
    order = Order.joins(:order_items, :user, :items)
    .where('items.user': self)
    .select('sum(order_items.quantity) as total_count')
    .select("user_id")
    .group('user_id')
    .order('total_count DESC')
    .limit(1).first

    if order
      order.user.name
    else
      "n/a"
    end
  end

  def top_customer_by_revenue
    order = Order.joins(:order_items, :user, :items)
    .where('items.user': self)
    .select('sum(order_items.quantity * order_items.price) as total_revenue')
    .select("user_id")
    .group('user_id')
    .order('total_revenue DESC')
    .limit(1).first

    if order
      order.user.name
    else
      "n/a"
    end
  end
end
