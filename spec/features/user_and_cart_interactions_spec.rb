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
  end
end





# I do NOT see the link to empty my cart
