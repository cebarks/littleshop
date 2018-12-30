require 'rails_helper'

describe 'As an admin user when I visit a users profile and I click on a link for orders show page' do
  it ' URL route should be /admin/orders/id' do
    @admin = create(:admin)
    @user = create(:user)
    @order_1 = create(:order, user: @user_1)

    post_login(admin)

    visit admin_user(user)

    within "order-0" do
      click_on "View Order"
    end

    expect(current_path).to eq()

    end
  end
end








# - the ID of the order
# - the date the order was made
# - the date the order was last updated
# - the current status of the order
# - each item the user ordered, including name, description, thumbnail, quantity, price and subtotal
# - the total quantity of items in the whole order
# - the grand total of all items for that order
