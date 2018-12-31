require 'rails_helper'

RSpec.describe "As a registered user" do
  describe "When I visit my profile and click on a link for an order's show page" do
    before(:each) do
      @user_1 = create(:user)

      @order_1 = create(:order, user: @user_1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit profile_path
    end

    it "my URI pattern is now /profile/orders/:order_id" do
      within("#order-0") do
        click_on @order_1.id
      end

      expect(current_path).to eq(profile_order_path(@order_1))
    end

    it "shows the id, creation date, update date, status, items, total item quantity and grand total for an order" do
      within("#order-0") do
        click_on @order_1.id
      end

      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_1.created_at)
      expect(page).to have_content(@order_1.updated_at)
      expect(page).to have_content(@order_1.status)
      expect(page).to have_content(@order_1.total_quantity)
      expect(page).to have_content(@order_1.grand_total)

      @order_1.order_items.each_with_index do |order_item, index|
        within "#item-#{index}" do
          expect(page).to have_content(order_item.item.name)
          expect(page).to have_content(order_item.item.description)
          expect(page.find(".item-thumb")['src']).to have_content(order_item.item.image_url)
          expect(page).to have_content(order_item.quantity)
          expect(page).to have_content("$#{order_item.price}")
          expect(page).to have_content("$#{order_item.subtotal}")
          save_and_open_page
        end
      end
    end
  end
end
