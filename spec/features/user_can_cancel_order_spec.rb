require 'rails_helper'

describe 'As a registered user when a single orders show page that is status:pending' do
  before(:each) do
    @user_1 = create(:user)
    @order_1 = create(:order, user: @user_1, status: 0)

    post_login(@user_1)

    visit profile_order_path(@order_1)
  end
  it 'I see a button or link to cancel the order' do
    
    expect(page).to have_selector(:link_or_button, 'Cancel Order')
  end
end



# When I click the cancel button for an order, the following happens:
# - Each row in the "order items" table is given a status of "unfulfilled"
# - The order itself is given a status of "cancelled"
# - Any item quantities in the order that were previously fulfilled have their quantities returned to their respective merchant's inventory for that item.
# - I am returned to my profile page
# - I see a flash message telling me the order is now cancelled
# - And I see that this order now has an updated status of "cancelled"
