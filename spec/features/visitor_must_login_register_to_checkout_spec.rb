require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I have items in my cart and I visit the cart show page" do
    it "I am told that I must register or login to finish the checkout" do
      visit cart_path
      
      expect(page).to have_content('You must register or login to finish the checkout process.')

      expect(page).to have_link('register', href: register_path)
      expect(page).to have_link('login', href: login_path)
    end
  end
end
