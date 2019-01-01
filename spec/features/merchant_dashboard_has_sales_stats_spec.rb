require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "When I visit my dashboard" do
    describe "the statistics area" do
      before(:each) do
        @merchant = create(:merchant)
        @item_1, @item_2, @item_3, @item_4, @item_5 = create_list(:item, 5, user: @merchant)
        @customer_1, @customer_2, @customer_3 = create_list(:user, 3)

        post_login(@merchant)

        visit profile_path
      end

      it "exists" do
        expect(page).to have_css('#dashboard-stats')
      end

      it "shows top 5 items I have sold by quantity" do
        @order_1 = create(:order, items_count: 0)

        OrderItem.create!(order: @order_1, item: @item_1, quantity: 5, price: 1)
        OrderItem.create!(order: @order_1, item: @item_2, quantity: 4, price: 1)
        OrderItem.create!(order: @order_1, item: @item_3, quantity: 3, price: 1)
        OrderItem.create!(order: @order_1, item: @item_4, quantity: 2, price: 1)
        OrderItem.create!(order: @order_1, item: @item_5, quantity: 1, price: 1)

        expect(page).to have_content("My Top 5 Items: #{@item_1.name}, #{@item_2.name}, #{@item_3.name}, #{@item_4.name}, #{@item_5.name}")
      end

      it "shows total quantity of items I've sold, and as a percentage against my sold units plus remaining inventory" do
        @order_1 = create(:order, items_count: 0)

        OrderItem.create!(order: @order_1, item: @item_1, quantity: 5, price: 1)

        expect(page).to have_content("Sold Items: #{@merchant.items_sold} (#{@merchant.items_sold_percentage.round(3) * 100}% of total inventory)")
      end

      it "shows top 3 states where my items were shipped" do
        @customer_1.state = 'CO'
        @customer_2.state = 'CA'
        @customer_3.state = 'NY'

        @order_1 = create(:order, user: @customer_1, items_count: 0)
        OrderItem.create!(order: @order_1, item: @item_1, quantity: 5, price: 1)

        @order_2_1 = create(:order, user: @customer_2, items_count: 0)
        OrderItem.create!(order: @order_2_1, item: @item_1, quantity: 5, price: 1)
        @order_2_2 = create(:order, user: @customer_2, items_count: 0)
        OrderItem.create!(order: @order_2_2, item: @item_1, quantity: 5, price: 1)

        @order_3_1 = create(:order, user: @customer_3, items_count: 0)
        OrderItem.create!(order: @order_3_1, item: @item_1, quantity: 5, price: 1)
        @order_3_2 = create(:order, user: @customer_3, items_count: 0)
        OrderItem.create!(order: @order_3_2, item: @item_1, quantity: 5, price: 1)
        @order_3_3 = create(:order, user: @customer_3, items_count: 0)
        OrderItem.create!(order: @order_3_3, item: @item_1, quantity: 5, price: 1)

        expect(page).to have_content("Top 3 States: CO, CA, NY")
      end

      it "shows top 3 city/state where my items were shipped" do
        @customer_1.state = 'CO'
        @customer_1.city = 'Denver'
        @customer_2.state = 'CA'
        @customer_2.city = 'San Francisco'
        @customer_3.state = 'NY'
        @customer_3.city = 'New York'

        @order_1 = create(:order, user: @customer_1, items_count: 0)
        OrderItem.create!(order: @order_1, item: @item_1, quantity: 5, price: 1)

        @order_2_1 = create(:order, user: @customer_2, items_count: 0)
        OrderItem.create!(order: @order_2_1, item: @item_1, quantity: 5, price: 1)
        @order_2_2 = create(:order, user: @customer_2, items_count: 0)
        OrderItem.create!(order: @order_2_2, item: @item_1, quantity: 5, price: 1)

        @order_3_1 = create(:order, user: @customer_3, items_count: 0)
        OrderItem.create!(order: @order_3_1, item: @item_1, quantity: 5, price: 1)
        @order_3_2 = create(:order, user: @customer_3, items_count: 0)
        OrderItem.create!(order: @order_3_2, item: @item_1, quantity: 5, price: 1)
        @order_3_3 = create(:order, user: @customer_3, items_count: 0)
        OrderItem.create!(order: @order_3_3, item: @item_1, quantity: 5, price: 1)

        expect(page).to have_content("Top 3 City/State Combos: Denver, CO; San Francisco, CA; New York, NY")
      end

      it "shows name of the user with the most orders from me" do
        customer_1_orders = create_list(:order, 6, user: @customer_1, items_count: 0)
        customer_1_orders.each do |order|
          OrderItem.create!(order: order, item: @item_1, quantity: 5, price: 1)
        end

        customer_2_orders = create_list(:order, 4, user: @customer_2, items_count: 0)
        customer_2_orders.each do |order|
          OrderItem.create!(order: order, item: @item_1, quantity: 5, price: 1)
        end

        customer_3_orders = create_list(:order, 2, user: @customer_3, items_count: 0)
        customer_3_orders.each do |order|
          OrderItem.create!(order: order, item: @item_1, quantity: 5, price: 1)
        end

        expect(page).to have_content("Top Customer by Order Count: #{@customer_1.name}")
      end

      it "shows name of the user who bought the most total items from me" do
        order_1 = create(:order, items_count: 0, user: @customer_1)
        OrderItem.create!(order: order_1, item: @item_1, quantity: 5, price: 1)
        order_2 = create(:order, items_count: 0, user: @customer_2)
        OrderItem.create!(order: order_2, item: @item_1, quantity: 3, price: 1)
        order_3 = create(:order, items_count: 0, user: @customer_3)
        OrderItem.create!(order: order_3, item: @item_1, quantity: 1, price: 1)

        expect(page).to have_content("Top Customer by Quantity: #{@customer_1.name}")
      end

      it "shows top 3 users who have spent the most money on my items" do
        order_1 = create(:order, items_count: 0, user: @customer_1)
        OrderItem.create!(order: order_1, item: @item_1, quantity: 5, price: 2)
        order_2 = create(:order, items_count: 0, user: @customer_2)
        OrderItem.create!(order: order_2, item: @item_1, quantity: 4, price: 3)
        order_3 = create(:order, items_count: 0, user: @customer_3)
        OrderItem.create!(order: order_3, item: @item_1, quantity: 1, price: 1)
        expect(page).to have_content("Top Customer by Revenue: #{@customer_2.name}")
      end
    end
  end
end

# As a merchant
# When I visit my dashboard, I see an area with statistics:
# - top 5 items I have sold by quantity
# - total quantity of items I've sold, and as a percentage against my sold units plus remaining inventory (eg, if I have sold 1,000 things and still have 9,000 things in inventory, the message would say something like "Sold 1,000 items, which is 10% of your total inventory")
# - top 3 states where my items were shipped
# - top 3 city/state where my items were shipped (Springfield, MI should not be grouped with Springfield, CO)
# - name of the user with the most orders from me (pick one if there's a tie)
# - name of the user who bought the most total items from me (pick one if there's a tie)
# - top 3 users who have spent the most money on my items
