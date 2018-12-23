require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zipcode)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should have_many(:items)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_numericality_of(:zipcode)}
  end
  describe 'Class methods'do
    it '.merchants should return a list of only merchants' do
      merchant_1 = create(:merchant)
      create(:user)
      all_merchants = [merchant_1]

      expect(User.merchants).to eq(all_merchants)
    end
    it '.enabled_merchant should return enabled merchants' do
      merchant_1 = create(:merchant)
      create(:merchant, :disabled)

      expect(User.enabled_merchants).to eq([merchant_1])
    end
    it '.default_users should return default users only' do
      user_1 = create(:user)
      user_2 = create(:user, :disabled)
      create(:merchant)
      total = [user_1, user_2]

      expect(User.default_users).to eq(total)
    end
    it '.top_3_merchants_by_profit' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      item_1 = create(:item, user: merchant_1, price: 10)
      item_2 = create(:item, user: merchant_2, price: 20)
      item_3 = create(:item, user: merchant_3, price: 30)
      order_1 = Order.create!(status: 1)
      order_item_1 = OrderItem.create!(order: order_1, item: item_2, price: 10, quantity: 1)
      order_item_2 = OrderItem.create!(order: order_1, item: item_2, price: 990, quantity: 99)
      order_item_3 = OrderItem.create!(order: order_1, item: item_2, price: 500, quantity: 50)
      order_item_4 = OrderItem.create!(order: order_1, item: item_1, price: 1000, quantity: 100)
      order_item_5 = OrderItem.create!(order: order_1, item: item_3, price: 30, quantity: 1)

      expect(User.top_3_merchants_by_profit[0].name). to eq(merchant_2.name)
      expect(User.top_3_merchants_by_profit[1].name). to eq(merchant_1.name)
      expect(User.top_3_merchants_by_profit[2].name). to eq(merchant_3.name)
    end
    it '.top_3_merchants_by_items_sold' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      item_1 = create(:item, user: merchant_1, price: 10)
      item_2 = create(:item, user: merchant_2, price: 20)
      item_3 = create(:item, user: merchant_3, price: 30)
      order_1 = Order.create!(status: 1)
      order_item_1 = OrderItem.create!(order: order_1, item: item_2, price: 10, quantity: 1)
      order_item_2 = OrderItem.create!(order: order_1, item: item_2, price: 990, quantity: 99)
      order_item_3 = OrderItem.create!(order: order_1, item: item_2, price: 500, quantity: 50)
      order_item_4 = OrderItem.create!(order: order_1, item: item_1, price: 1000, quantity: 100)
      order_item_5 = OrderItem.create!(order: order_1, item: item_3, price: 30, quantity: 1)

      expect(User.top_3_merchants_by_items_sold[0].name).to eq(merchant_2.name)
      expect(User.top_3_merchants_by_items_sold[1].name).to eq(merchant_1.name)
      expect(User.top_3_merchants_by_items_sold[2].name).to eq(merchant_3.name)
    end
    it '.top_3_merchants_by_fulfillment_speed' do
      m_1 = create(:merchant)
      m_2 = create(:merchant)
      m_3 = create(:merchant)
      i_1 = m_1.items.create!(name: "a", description: "w", inventory_qty: 9999, price: 1)
      i_2 = m_2.items.create!(name: "b", description: "x", inventory_qty: 9999, price: 1)
      i_3 = m_3.items.create!(name: "c", description: "y", inventory_qty: 9999, price: 1)
      order_1 = Order.create!(status: 1, created_at: 50.days.ago)
      order_2 = Order.create!(status: 1, created_at: 13.days.ago)
      order_3 = Order.create!(status: 1, created_at: 5.days.ago)
      oi_1 = OrderItem.create!(item: i_1, order: order_1, quantity: 1, price: 1)
      oi_1 = OrderItem.create!(item: i_2, order: order_2, quantity: 1, price: 1)
      oi_1 = OrderItem.create!(item: i_3, order: order_3, quantity: 1, price: 1)

      expect(User.top_3_merchants_by_fulfillment_speed[0].name).to eq(m_3.name)
    end

  end
  describe 'instance methods' do
    describe '#active_items' do
      it 'should return a list of only active items' do
        merchant_1 = create(:merchant)
        item_1 = create(:item, user: merchant_1, status: true)
        create(:item, user: merchant_1, status: false)
        current_active_items = [item_1]

        expect(merchant_1.active_items).to eq(current_active_items)
      end
    end
    it '#earnings' do
      merchant_1 = create(:merchant)
      item_1 = create(:item, user: merchant_1, price: 30)
      order_1 = Order.create!(status: 1)
      order_2 = Order.create!(status: 2)
      order_item_1 = OrderItem.create!(order: order_1, item: item_1, price: 300, quantity: 10)
      order_item_2 = OrderItem.create!(order: order_2, item: item_1, price: 30, quantity: 1) #cancelled orders shouldn't count toward merchant earnings

      expect(merchant_1.earnings).to eq(300)
    end
    it '#items_sold' do
      merchant_1 = create(:merchant)
      item_1 = create(:item, user: merchant_1, price: 10)
      order_1 = Order.create!(status: 1)
      order_2 = Order.create!(status: 2)
      order_item_1 = OrderItem.create!(order: order_1, item: item_1, price: 50, quantity: 5)
      order_item_2 = OrderItem.create!(order: order_1, item: item_1, price: 1000, quantity: 100)

      expect(merchant_1.items_sold).to eq(5)
    end
    it '#fulfillment_speed' do
      #merchant fulfillment speed = avg(orders.updated_at - orders.created_at)
      m_1 = create(:merchant)
      item_1 = create(:item, user: m_1, price: 10)
      order_1 = Order.create!(status: 1, created_at: 2.days.ago)
      order_2 = Order.create!(status: 1, created_at: 3.days.ago)
      order_3 = Order.create!(status: 1, created_at: 5.days.ago)

      oi_1 = OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)
      oi_1 = OrderItem.create!(item: item_1, order: order_2, quantity: 1, price: 1)
      oi_1 = OrderItem.create!(item: item_1, order: order_3, quantity: 1, price: 1)

      expect(m_1.fulfillment_speed).to eq(3)
    end
  end
end
