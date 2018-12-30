require 'rails_helper'

RSpec.describe "As a registered user" do
  describe "When I visit my profile page and my account has ordered items" do
    before(:each) do
      @user = create(:user)
      @order = create(:order, user: @user)

      post_login @user

      visit profile_path
    end
    describe "I see every order I've made which includes" do
      within '#order-0' do
        it "the ID of the order, which is a link to the order show page" do
          expect(page).to have_link(order.id, href: profile_order_path(@order))
        end

        it "the date the order was made" do
          expect(page).to have_content(order.created_at)
        end

        it "the date the order was last updated" do
          expect(page).to have_content(order.updated_at)
        end

        it "the current status of the order" do
          expect(page).to have_content(order.status)
        end

        it "the total quantity of items in the order" do
          expect(page).to have_content(order.total_quantity)
        end

        it "the grand total of all items for that order" do
          expect(page).to have_content(order.grand_total)
        end
      end
    end
  end
end

# As a registered user
# When I visit my profile page
# If my account has ordered items
# I see every order I've made, which includes the following information:
# - the ID of the order, which is a link to the order show page
# - the date the order was made
# - the date the order was last updated
# - the current status of the order
# - the total quantity of items in the order
# - the grand total of all items for that order
