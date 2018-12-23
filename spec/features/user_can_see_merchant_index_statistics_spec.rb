require 'rails_helper'

describe "As a visitor" do
  describe "When i visit the merchant users index page" do
    describe "can see statistics" do
      it "can see top 3 merchants by price & quantity" do
        m_1 = create(:merchant)
        m_2 = create(:merchant)
        m_3 = create(:merchant)
        i_1 = m_1.items.create!(name: "a", description: "w", inventory_qty: 9999, price: 10000)
        i_2 = m_2.items.create!(name: "b", description: "x", inventory_qty: 9999, price: 500)
        i_3 = m_3.items.create!(name: "c", description: "y", inventory_qty: 9999, price: 99)
        order_1 = Order.create!(status: 1)
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
    i_1 = m_1.items.create!(name: "a", description: "w", inventory_qty: 9999, price: 1)
    i_2 = m_2.items.create!(name: "b", description: "x", inventory_qty: 9999, price: 1)
    i_3 = m_3.items.create!(name: "c", description: "y", inventory_qty: 9999, price: 1)
    order_1 = Order.create!(status: 1, created_at: 50.days.ago)
    order_2 = Order.create!(status: 1, created_at: 13.days.ago)
    order_3 = Order.create!(status: 1, created_at: 5.days.ago)
    oi_1 = OrderItem.create!(item: i_1, order: order_1, quantity: 1, price: 1)
    oi_1 = OrderItem.create!(item: i_2, order: order_2, quantity: 1, price: 1)
    oi_1 = OrderItem.create!(item: i_3, order: order_3, quantity: 1, price: 1)
    visit merchants_path

    within("#merchant-index-statistics") do
      expect(page).to have_content("Top 3 Merchants who fulfill orders the fastest:\n#{m_3.name}, who completes orders in #{m_3.fulfillment_speed} days on average\n#{m_2.name}, who completes orders in #{m_2.fulfillment_speed} days on average\n#{m_1.name}, who completes orders in #{m_1.fulfillment_speed} days on average")
    end
  end
  # it "can see bottom 3 merchants by order fulfillment speed" do
  # end
  # it "can see the top 3 states with most orders" do
  # end
  # it "can see the top 3 cities with most orders" do
  #   it "distinguishes city by its associated state" do #(Springfield, MI should not be grouped with Springfield, CO)
  #   end
  # end
  # it "can see the top 3 orders by quantity of items" do
  # end
# end
end
