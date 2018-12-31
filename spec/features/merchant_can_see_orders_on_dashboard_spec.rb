require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "When I visit my dashboard ('/dashboard')" do
    before(:each) do
      @order = create(:order, :pending)
      create(:order)
      @merchant = create(:merchant)
      @merchant = @order.items.first.user

      post_login(@merchant)

      visit dashboard_path
    end

    it "I see a list of pending orders containing items I sell" do
      within "#my-orders" do
        expect(page).to have_content(@order.id)
      end
    end

    describe "In the list of orders" do
      it "I see the ID of that order that is a link to that order's show page" do
        expect(page).to have_link(@order.id, href: dashboard_order_path(@order))
      end

      it "I see the date that order was made" do
        expect(page).to have_content(@order.created_at)
      end

      it "I see the total quantity of my items in the order" do
        expect(page).to have_content(@order.total_quantity_by_merchant(@merchant))
      end

      it "I see the total value of my items in the order" do
        expect(page).to have_content(@order.total_price_by_merchant(@merchant))
      end
    end
  end
end

# As a merchant
# When I visit my dashboard ("/dashboard")
# If any users have pending orders containing items I sell
# Then I see a list of these orders.
# Each order listed includes the following information:
# - the ID of the order, which is a link to the order show page ("/dashboard/orders/15")
# - the date the order was made
# - the total quantity of my items in the order
# - the total value of my items for that order
