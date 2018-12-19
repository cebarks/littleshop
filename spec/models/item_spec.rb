require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Validations' do
    it {should belong_to(:user)}
    it {should have_many(:order_items)}
    it {should have_many(:orders).through(:order_items)}
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:inventory_qty)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:user)}
  end
  describe 'Class Methods' do
    it '.amount_sold' do
      item_1 = Item.create(name: "Amaretto Sour", description: "a sweet nutty cocktail that calls for a full bodied spirit to pair with the bright citrus and sugar. di Amore Amaretto is an excellent choice with its rich body and caramel, almond flavors.", image_url: "https://bit.ly/2BoIMFi", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
      order_1 = Order.create(status: "complete")
      oi_1 = OrderItem.create(item_id: item_1, order_id: order_1, quantity: 49, price: item_1.price)
      require "pry"; binding.pry
      expect(Item.amount_sold(1)).to eq(OrderItem.last.quantity)
    end
  end
end
