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
      it "the ID of the order, which./spec/features/user_profile_displays_orders_spec.rb
       is a link to the order show page" do
        within '#order-0 .order-id' do
          expect(page).to have_link(@order.id, href: profile_order_path(@order))
        end
      end

      it "the date the order was made" do
        within '#order-0 .order-date' do
          expect(page).to have_content(@order.created_at)
        end
      end

      it "the date the order was last updated" do
        within '#order-0 .order-update' do
          expect(page).to have_content(@order.updated_at)
        end
      end

      it "the current status of the order" do
        within '#order-0 .order-status' do
          expect(page).to have_content(@order.status)
        end
      end

      it "the total quantity of items in the order" do
        within '#order-0 .order-quantity' do
          expect(page).to have_content(@order.total_quantity)
        end
      end

      it "the grand total of all items for that order" do
        within '#order-0 .order-grand-total' do
          expect(page).to have_content("#{@order.grand_total}")
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
