require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Validations' do
    it {should belong_to(:order)}
    it {should belong_to(:item)}
    it {should validate_presence_of(:order)}
    it {should validate_presence_of(:item)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:quantity)}
  end

  describe "Instance Methods" do
    it "#subtotal" do
      order = create(:order)
      oi = order.order_items.first

      expect(oi.subtotal).to eq(oi.price * oi.quantity)
    end
    it ".cancel_order_item" do
      user_1 = create(:user)
      item_1 = create(:item)
      item_2 = create(:item)
      order_1 = create(:order, items_count:0, user: user_1, status: 0)
      oi_1 = OrderItem.new(item: item_1, order: order_1, quantity: 1, price: 1, fulfillment: true)
      oi_2 = OrderItem.new(item: item_2, order: order_1, quantity: 1, price: 1, fulfillment: true)
      oi_1.save
      oi_2.save
      oi_1.cancel_order_item(order_1)
      oi_2.cancel_order_item(order_1)

      expect(order_1.order_items[0].fulfillment).to eq(false)
      expect(order_1.order_items[1].fulfillment).to eq(false)
    end
    it ".return_quantity" do
      user_1 = create(:user)
      item_1 = create(:item, inventory_qty: 9)
      item_2 = create(:item, inventory_qty: 3)
      order_1 = create(:order, items_count:0, user: user_1, status: 0)
      oi_1 = OrderItem.new(item: item_1, order: order_1, quantity: 4, price: 1, fulfillment: true)
      oi_2 = OrderItem.new(item: item_2, order: order_1, quantity: 2, price: 1, fulfillment: true)
      oi_1.save
      oi_2.save
      oi_1.return_quantity(order_1)
      oi_2.return_quantity(order_1)

      expect(order_1.order_items[0].quantity).to eq(0)
      expect(order_1.order_items[1].quantity).to eq(0)
    end
  end
end
