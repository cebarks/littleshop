require 'rails_helper'

describe "As a visitor" do
  describe "When i visit the merchant users index page" do
    describe "can see statistics" do
      it "can see top 3 merchants by price & quantity" do
        m_1 = create(:merchant)
        m_2 = create(:merchant)
        m_3 = create(:merchant)
        customer_1 = create(:user)
        i_1 = m_1.items.create!(name: "a", description: "w", inventory_qty: 9999, price: 10000)
        i_2 = m_2.items.create!(name: "b", description: "x", inventory_qty: 9999, price: 500)
        i_3 = m_3.items.create!(name: "c", description: "y", inventory_qty: 9999, price: 99)
        order_1 = Order.create!(status: 1, user: customer_1)
        oi_1 = OrderItem.create!(order: order_1, item: i_1, price: 90000, quantity: 9)
        oi_2 = OrderItem.create!(order: order_1, item: i_2, price: 25000, quantity: 50)
        oi_3 = OrderItem.create!(order: order_1, item: i_3, price: 99, quantity: 1)

        visit merchants_path

        within("#merchant-index-statistics") do
          expect(page).to have_content("Top 3 Merchants with the highest profit:\n#{m_1.name} - $90,000.00\n#{m_2.name} - $25,000.00\n#{m_3.name} - $99.00")
          expect(page).to have_content("Top 3 Merchants who've sold the most items:\n#{m_2.name} - 50\n#{m_1.name} - 9\n#{m_3.name} - 1")
        end
      end
    end
  end
  it "can see top 3 merchants by order fulfillment speed" do
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
    oi_2 = OrderItem.create!(item: i_2, order: order_2, quantity: 1, price: 1)
    oi_3 = OrderItem.create!(item: i_3, order: order_3, quantity: 1, price: 1)
    visit merchants_path

    within("#merchant-index-statistics") do
      expect(page).to have_content("Top 3 Merchants who fulfill orders the fastest:\n#{m_3.name}, who completes orders in 5 day(s) on average\n#{m_2.name}, who completes orders in 13 day(s) on average\n#{m_1.name}, who completes orders in 50 day(s) on average")
    end
  end
  it "can see bottom 3 merchants by order fulfillment speed" do
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
    oi_2 = OrderItem.create!(item: i_2, order: order_2, quantity: 1, price: 1)
    oi_3 = OrderItem.create!(item: i_3, order: order_3, quantity: 1, price: 1)
    visit merchants_path

    within("#merchant-index-statistics") do
      expect(page).to have_content("Merchants who were slowest at fulfilling orders:\n#{m_1.name}, who completes orders in 50 day(s) on average\n#{m_2.name}, who completes orders in 13 day(s) on average\n#{m_3.name}, who completes orders in 5 day(s) on average")
    end
  end
  it "can see the top 3 states where orders were shipped" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    customer_1 = create(:user, state: "VT")
    customer_2 = create(:user, state: "CA") #make california have the most orders
    customer_3 = create(:user, state: "AK")
    item_1 = merchant_1.items.create!(name: "a", description: "w", inventory_qty: 9999, price: 1)
    item_2 = merchant_2.items.create!(name: "b", description: "x", inventory_qty: 9999, price: 1)
    item_3 = merchant_3.items.create!(name: "c", description: "y", inventory_qty: 9999, price: 1)
    order_1 = Order.create(status: 1, user: customer_1)
    order_2 = Order.create(status: 1, user: customer_2)
    order_3 = Order.create(status: 1, user: customer_2)
    order_4 = Order.create(status: 1, user: customer_2)
    order_5 = Order.create(status: 1, user: customer_3)
    order_6 = Order.create(status: 1, user: customer_3)
    oi_1 = OrderItem.create!(item: item_1, order: order_1, price: 500, quantity: 1203)
    oi_2 = OrderItem.create!(item: item_2, order: order_2, price: 500, quantity: 1203)
    oi_3 = OrderItem.create!(item: item_3, order: order_3, price: 500, quantity: 1203)
    oi_4 = OrderItem.create!(item: item_2, order: order_4, price: 500, quantity: 1203)
    oi_5 = OrderItem.create!(item: item_1, order: order_5, price: 500, quantity: 1203)
    oi_6 = OrderItem.create!(item: item_3, order: order_6, price: 500, quantity: 1203)

    visit merchants_path

    within("#merchant-index-statistics") do
      expect(page).to have_content("CA - 3\nAK - 2\nVT - 1")
    end
  end
  it "can see the top 3 cities with most orders" do
    merchant_1 = create(:merchant)
    customer_1 = create(:user, city: "Springfield", state: "MI")
    customer_2 = create(:user, city: "Springfield", state: "CO") #distinguishes city by its associated state
    customer_3 = create(:user, city: "Greenville", state: "NC")
    item_1 = create(:item, user: merchant_1)
    order_1 = Order.create(status: 1, user: customer_1)
    order_2 = Order.create(status: 1, user: customer_2)
    order_3 = Order.create(status: 1, user: customer_2)
    order_4 = Order.create(status: 1, user: customer_2)
    order_5 = Order.create(status: 1, user: customer_3)
    order_6 = Order.create(status: 1, user: customer_3)
    oi_1 = OrderItem.create!(item: item_1, order: order_1, price: 333, quantity: 1201)
    oi_2 = OrderItem.create!(item: item_1, order: order_2, price: 500, quantity: 1203)
    oi_3 = OrderItem.create!(item: item_1, order: order_3, price: 500, quantity: 1203)
    oi_4 = OrderItem.create!(item: item_1, order: order_4, price: 500, quantity: 1203)
    oi_5 = OrderItem.create!(item: item_1, order: order_5, price: 500, quantity: 1203)
    oi_6 = OrderItem.create!(item: item_1, order: order_6, price: 500, quantity: 1203)

    visit merchants_path

    within("#merchant-index-statistics") do
      expect(page).to have_content("Top 3 Cities with the most orders:\nSpringfield, CO - 3\nGreenville, NC - 2\nSpringfield, MI - 1")
    end
  end

  it "can see the top 3 orders by quantity of items" do
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

    visit merchants_path

    within("#merchant-index-statistics") do
      expect(page).to have_content("Top 3 biggest orders:\nOrder #{Order.top_3_biggest_orders[0].id} - #{Order.top_3_biggest_orders[0].size} items!\nOrder #{Order.top_3_biggest_orders[1].id} - #{Order.top_3_biggest_orders[1].size} items!\nOrder #{Order.top_3_biggest_orders[2].id} - #{Order.top_3_biggest_orders[2].size} items!")
    end
  end
end
