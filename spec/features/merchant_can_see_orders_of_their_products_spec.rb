require 'rails_helper'

describe 'A merchant who logs into our web app' do
  describe 'when visiting an order show page from their dashboard' do
    it 'displays customer name and shipping address' do
      customer_1 = create(:user)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      item_1 = create(:item, user: merchant_1)
      item_2 = create(:item, user: merchant_2)
      order_1 = create(:order, user: customer_1)
      order_2 = create(:item, user: customer_1)
      order_item_1 = OrderItem.create(item: item_1, order: order_1, price: 50, quantity: 10)
      order_item_2 = OrderItem.create(item: item_2, order: order_1, price: 33, quantity: 4)
      order_item_3 = OrderItem.create(item: item_1, order: order_1, price: 1, quantity: 2)

      post_login(merchant_1)

      visit dashboard_path
      require "pry"; binding.pry

      click_on order_1.id
      expect(page).to have_content(customer_1.name)
      expect(page).to have_content(customer_1.address)
      expect(page).to not_have_content(item_2.name)
      expect(page).to not_have_content(item_2.description)
    end
  end
end
