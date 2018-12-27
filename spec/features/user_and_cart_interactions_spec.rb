require 'rails_helper'

describe 'As a visitor or registered user' do
  describe 'When I add NO items to my cart yet and I visit my cart ("/cart")' do
    it 'sees a message that my cart is empty' do

      visit cart_path

      expect(page).to have_content("You currently have 0 items in your cart.")

      user_1 = create(:user)

      post_login(user_1)

      visit cart_path

      expect(page).to have_content("You currently have 0 items in your cart.")
    end
    it 'should not see a link to empty cart' do

      visit cart_path

      expect(page).to_not have_selector(:link_or_button, 'Empty Cart Contents')
    end
  end
  describe 'When I have added items to my cart And I visit my cart ("/cart")' do
    it 'I see all items I added to my cart And I see a link to empty my cart' do
      merchant = create(:user, role: 1)
      user = create(:user)
      item_1 = create(:item, user: merchant)
      item_2 = create(:item, user: merchant)
      item_3 = create(:item, user: merchant)
      order_1 = Order.create!(status: 3, created_at: 2.days.ago, user: user)
      order_2 = Order.create!(status: 3, created_at: 3.days.ago, user: user)
      OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)
      OrderItem.create!(item: item_2, order: order_2, quantity: 1, price: 1)

      visit item_path(item_1)
      click_button('Add To Cart')

      visit item_path(item_2)
      click_button('Add To Cart')

      visit cart_path

      within("#cart-items") do
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_1.price)
        expect(page).to have_content(item_1.user.name)
        expect(page).to have_content(item_2.name)
        expect(page).to have_content(item_2.price)
        expect(page).to have_content(item_2.user.name)
        expect(page).to_not have_content(item_3.name)
        page.find("#tiny-drink-pic-#{item_1.id}")
        page.find("#tiny-drink-pic-#{item_2.id}")
      end

      expect(page).to have_content("You currently have 2 items in your cart.")
      expect(page).to have_selector(:link_or_button, 'Empty Cart Contents')
    end
  end
  describe 'As a visitor or registered user when I have items in my cart' do
    describe 'And I visit my cart ("/cart") and click empty cart' do
      it 'should be returned to the cart with no items in it' do
        merchant = create(:user, role: 1)
        user = create(:user)
        item_1 = create(:item, user: merchant)
        item_2 = create(:item, user: merchant)
        order_1 = Order.create!(status: 3, created_at: 2.days.ago, user: user)
        order_2 = Order.create!(status: 3, created_at: 3.days.ago, user: user)
        OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)
        OrderItem.create!(item: item_2, order: order_2, quantity: 1, price: 1)

        visit item_path(item_1)
        click_button('Add To Cart')

        visit item_path(item_2)
        click_button('Add To Cart')

        visit cart_path

        click_button('Empty Cart Contents.')

        expect(current_path).to eq(cart_path)
        expect(page).to have_content("You currently have 0 items in your cart.")
      end
    end
  end
end
