class Item < ApplicationRecord
  validates_presence_of :name, :description, :inventory_qty, :price, :user
  validates_inclusion_of :status, :in => [true, false]
  belongs_to :user
  has_many :order_items
  has_many :orders, through: :order_items



  def self.amount_sold(id)
    OrderItem.where(item_id: id).sum(:quantity)
  end
end
