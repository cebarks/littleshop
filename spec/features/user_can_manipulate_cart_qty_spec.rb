require 'rails_helper'

describe 'As a visitor or registered user' do
  describe 'When I have items in and visit my cart' do
    it 'should I see a separate button to remove each item from my cart' do
      cart = Cart.new(Hash.new(0))
      merchant = create(:user, role: 1)
      user = create(:user)
      item_1 = create(:item, user: merchant)
      item_2 = create(:item, user: merchant)
      order_1 = Order.create!(status: 3, created_at: 2.days.ago, user: user)
      order_2 = Order.create!(status: 3, created_at: 3.days.ago, user: user)
      OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)
      OrderItem.create!(item: item_2, order: order_2, quantity: 1, price: 1)

      cart.add_item(item_1)
      cart.add_item(item_2)

      visit cart_path

      within("cart-item-#{item_1.id}") do
        expect(page).to have_selector(:link_or_button, 'Remove Item')
      end

      within("cart-item-#{item_2.id}") do
        expect(page).to have_selector(:link_or_button, 'Remove Item')
      end
    end
  end
end




# - clicking this button will remove the item but not other items
#
# I see a button or link to increment the count of items I want to purchase
# - I cannot increment the count beyond the merchant's inventory size
#
# I see a button or link to decrement the count of items I want to purchase
# - If I decrement the count to 0 the item is immediately removed from my cart
