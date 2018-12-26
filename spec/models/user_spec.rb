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
  describe 'Relationships' do
    it { should have_many(:orders) }
    it { should have_many(:items) }
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
      customer_1 = create(:user)
      item_1 = create(:item, user: merchant_1, price: 10)
      item_2 = create(:item, user: merchant_2, price: 20)
      item_3 = create(:item, user: merchant_3, price: 30)
      order_1 = Order.create!(status: 1, user: customer_1)
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
      customer_1 = create(:user)
      item_1 = create(:item, user: merchant_1, price: 10)
      item_2 = create(:item, user: merchant_2, price: 20)
      item_3 = create(:item, user: merchant_3, price: 30)
      order_1 = Order.create!(status: 1, user: customer_1)
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
      customer_1 = create(:user)
      i_1 = m_1.items.create!(name: "a", description: "w", inventory_qty: 9999, price: 1)
      i_2 = m_2.items.create!(name: "b", description: "x", inventory_qty: 9999, price: 1)
      i_3 = m_3.items.create!(name: "c", description: "y", inventory_qty: 9999, price: 1)
      order_1 = Order.create!(status: 1, created_at: 50.days.ago, user: customer_1)
      order_2 = Order.create!(status: 1, created_at: 13.days.ago, user: customer_1)
      order_3 = Order.create!(status: 1, created_at: 5.days.ago, user: customer_1)
      oi_1 = OrderItem.create!(item: i_1, order: order_1, quantity: 1, price: 1)
      oi_1 = OrderItem.create!(item: i_2, order: order_2, quantity: 1, price: 1)
      oi_1 = OrderItem.create!(item: i_3, order: order_3, quantity: 1, price: 1)

      expect(User.top_3_merchants_by_fulfillment_speed[0].name).to eq(m_3.name)
    end
    it '.bottom_3_merchants_by_fulfillment_speed' do
      m_1 = create(:merchant)
      m_2 = create(:merchant)
      m_3 = create(:merchant)
      customer_1 = create(:user)
      i_1 = m_1.items.create!(name: "a", description: "w", inventory_qty: 9999, price: 1)
      i_2 = m_2.items.create!(name: "b", description: "x", inventory_qty: 9999, price: 1)
      i_3 = m_3.items.create!(name: "c", description: "y", inventory_qty: 9999, price: 1)
      order_1 = Order.create!(status: 1, created_at: 50.days.ago, user: customer_1)
      order_2 = Order.create!(status: 1, created_at: 13.days.ago, user: customer_1)
      order_3 = Order.create!(status: 1, created_at: 5.days.ago, user: customer_1)
      oi_1 = OrderItem.create!(item: i_1, order: order_1, quantity: 1, price: 1)
      oi_1 = OrderItem.create!(item: i_2, order: order_2, quantity: 1, price: 1)
      oi_1 = OrderItem.create!(item: i_3, order: order_3, quantity: 1, price: 1)

      expect(User.bottom_3_merchants_by_fulfillment_speed[0].name).to eq(m_1.name)
    end
    it '.top_3_states_by_order_count' do
      merchant_1 = create(:merchant)
      customer_1 = create(:user, state: "VT")
      customer_2 = create(:user, state: "CA")
      customer_3 = create(:user, state: "AK")
      item_1 = create(:item, user: merchant_1)
      order_1 = Order.create(status: 1, user: customer_1)
      order_2 = Order.create(status: 1, user: customer_2)
      order_3 = Order.create(status: 1, user: customer_2)
      order_4 = Order.create(status: 1, user: customer_2)
      order_5 = Order.create(status: 1, user: customer_3)
      order_6 = Order.create(status: 1, user: customer_3)
      oi_1 = OrderItem.create!(item: item_1, order: order_1, price: 500, quantity: 1203)
      oi_2 = OrderItem.create!(item: item_1, order: order_2, price: 500, quantity: 1203)
      oi_3 = OrderItem.create!(item: item_1, order: order_3, price: 500, quantity: 1203)
      oi_4 = OrderItem.create!(item: item_1, order: order_4, price: 500, quantity: 1203)
      oi_5 = OrderItem.create!(item: item_1, order: order_5, price: 500, quantity: 1203)
      oi_6 = OrderItem.create!(item: item_1, order: order_6, price: 500, quantity: 1203)

      expect(User.top_3_states_by_order_count[0].state).to eq("CA")
      expect(User.top_3_states_by_order_count[1].state).to eq("AK")
      expect(User.top_3_states_by_order_count[2].state).to eq("VT")
    end
    it '.top_3_cities_by_order_count' do
      merchant_1 = create(:merchant)
      customer_1 = create(:user, city: "Springfield", state: "MI")
      customer_2 = create(:user, city: "Birmingham", state: "CO")
      customer_3 = create(:user, city: "Greenville")
      item_1 = create(:item, user: merchant_1)
      order_1 = Order.create(status: 1, user: customer_1)
      order_2 = Order.create(status: 1, user: customer_2)
      order_3 = Order.create(status: 1, user: customer_2)
      order_4 = Order.create(status: 1, user: customer_2)
      order_5 = Order.create(status: 1, user: customer_3)
      order_6 = Order.create(status: 1, user: customer_3)
      oi_1 = OrderItem.create!(item: item_1, order: order_1, price: 500, quantity: 1203)
      oi_2 = OrderItem.create!(item: item_1, order: order_2, price: 500, quantity: 1203)
      oi_3 = OrderItem.create!(item: item_1, order: order_3, price: 500, quantity: 1203)
      oi_4 = OrderItem.create!(item: item_1, order: order_4, price: 500, quantity: 1203)
      oi_5 = OrderItem.create!(item: item_1, order: order_5, price: 500, quantity: 1203)
      oi_6 = OrderItem.create!(item: item_1, order: order_6, price: 500, quantity: 1203)

      expect(User.top_3_cities_by_order_count[0].city).to eq("Birmingham")
      expect(User.top_3_cities_by_order_count[1].city).to eq("Greenville")
      expect(User.top_3_cities_by_order_count[2].city).to eq("Springfield")
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
  end
end
