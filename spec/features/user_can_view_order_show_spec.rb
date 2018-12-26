require 'rails_helper'

RSpec.describe "As a registered user" do
  describe "When I visit my profile and click on a link for an order's show page" do
    it "my URI pattern is now /profile/orders/:order_id" do
      user_1 = create(:user)

      order_1 = create(:order, user: user_1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit profile_path

      within("#order-1") do
        click_on 'Show Page'
      end

      expect(current_path).to eq(profile_orders_path(order_1))
    end
  end
end
