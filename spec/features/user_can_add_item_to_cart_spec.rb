require 'rails_helper'

  describe 'A user on our web app' do
    it 'can add item to cart' do
      create(:merchant)
      item_1 = create(:item)
      order_1 = Order.create!(status: 3)
      OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)

      visit item_path(item_1)

      click_button('Add To Cart')


      expect(current_path).to eq(items_path)
      expect(page).to have_content("You now have 1 glass of #{item_1.name} in your cart.")
      expect(page).to have_content("Cart: 1")

      visit item_path(item_1)

      click_button('Add To Cart')
      expect(page).to have_content("You now have 2 glasses of #{item_1.name} in your cart.")
      expect(page).to have_content("Cart: 2")
    end
  end
