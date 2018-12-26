require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:status)}
    it {should have_many(:items).through(:order_items)}
    it {should have_many(:order_items)}
  end
  describe 'Relationships' do
    it { should belong_to(:user) }
  end
  describe 'Class Methods' do
    it '.top_3_biggest_orders' do
      merchant_1 = create(:merchant)
      customer_1 = create(:user)
      customer_2 = create(:user)
      customer_3 = create(:user)
      item_1 = create(:item, user: merchant_1)
      order_1 = Order.create!(status: 1, user: customer_1)
      order_2 = Order.create!(status: 1, user: customer_2)
      order_3 = Order.create!(status: 1, user: customer_2)
      order_4 = Order.create!(status: 1, user: customer_2)
      order_5 = Order.create!(status: 1, user: customer_3)
      order_6 = Order.create!(status: 1, user: customer_3)
      oi_1 = OrderItem.create!(item: item_1, order: order_1, price: 500, quantity: 1)
      oi_2 = OrderItem.create!(item: item_1, order: order_2, price: 500, quantity: 2)
      oi_3 = OrderItem.create!(item: item_1, order: order_3, price: 500, quantity: 3)
      oi_4 = OrderItem.create!(item: item_1, order: order_4, price: 500, quantity: 14)
      oi_5 = OrderItem.create!(item: item_1, order: order_5, price: 500, quantity: 50)
      oi_6 = OrderItem.create!(item: item_1, order: order_6, price: 500, quantity: 60)

      expect(Order.top_3_biggest_orders[0]).to eq(order_6)
    end
  end
end
