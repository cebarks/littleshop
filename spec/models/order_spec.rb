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
      OrderItem.create!(item: item_1, order: order_1, price: 500, quantity: 1)
      OrderItem.create!(item: item_1, order: order_2, price: 500, quantity: 2)
      OrderItem.create!(item: item_1, order: order_3, price: 500, quantity: 3)
      OrderItem.create!(item: item_1, order: order_4, price: 500, quantity: 14)
      OrderItem.create!(item: item_1, order: order_5, price: 500, quantity: 50)
      OrderItem.create!(item: item_1, order: order_6, price: 500, quantity: 60)

      expect(Order.top_3_biggest_orders[0]).to eq(order_6)
    end
  end
  describe "Instance Methods" do
    it "#total_quantity" do
      item_1, item_2 = create_list(:item, 2)

      order_1 = Order.create!(status: 1, user: create(:user))

      OrderItem.create!(item: item_1, order: order_1, price: 500, quantity: 1)
      OrderItem.create!(item: item_2, order: order_1, price: 500, quantity: 2)

      expect(order_1.total_quantity).to eq(3)
    end
    it "#grand_total" do
      item_1, item_2 = create_list(:item, 2)

      order_1 = Order.create!(status: 1, user: create(:user))

      OrderItem.create!(item: item_1, order: order_1, price: 500, quantity: 1)
      OrderItem.create!(item: item_2, order: order_1, price: 500, quantity: 2)

      expect(order_1.grand_total).to eq(1500)
    end
    it "#cancel_all" do
      user_1 = create(:user)
      item_1 = create(:item)
      item_2 = create(:item)
      order_1 = create(:order, items_count: 0, user: user_1, status: 0)
      oi_1 = OrderItem.create(item: item_1, order: order_1, quantity: 1, price: 1)
      oi_2 = OrderItem.create(item: item_2, order: order_1, quantity: 1, price: 1)
      order_1.cancel_all(order_1)

      expect(order_1.order_items[0].fulfillment).to eq(false)
      expect(order_1.order_items[1].fulfillment).to eq(false)
    end
    describe "by_merchant" do
      before(:each) do
        @item_1, @item_2 = create_list(:item, 2)
        @merchant = @item_1.user
        @item_3 = create(:item, user: @merchant)
        @order = create(:order, items_count: 0)

        oi_1 = OrderItem.create!(item: @item_1, order: @order, price: 100, quantity: 1)
        oi_2 = OrderItem.create!(item: @item_2, order: @order, price: 500, quantity: 1)
        oi_2 = OrderItem.create!(item: @item_3, order: @order, price: 200, quantity: 3)
      end

      it "#total_quantity_by_merchant" do
        expect(@order.total_quantity_by_merchant(@merchant)).to eq(4)
      end

      it "#total_price_by_merchant" do
        expect(@order.total_price_by_merchant(@merchant)).to eq(700)
      end
    end
  end
end
