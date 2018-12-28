require 'rails_helper'

describe 'As an admin user' do
  describe 'When I visit the merchants index page' do
    it 'shows merchant names as links' do
      admin = create(:admin)
      merchant_1 = create(:merchant)

      post_login(admin)

      visit merchants_path

      within "#merchant-#{merchant_1.id}" do
        click_link("#{merchant_1.name}")
      end

      expect(current_path).to eq(admin_merchant_path(merchant_1))
    end
  end
  describe 'When I visit admin_merchant_path' do
    it 'I should see the same content as a merchant looking at their own dashboard' do
      admin = create(:admin)
      merchant_1 = create(:merchant)

      post_login(admin)

      visit admin_merchant_path(merchant_1)

      expect(page).to have_content("#{merchant_1.name}")
      expect(page).to have_content("#{merchant_1.address}")
      expect(page).to have_content("#{merchant_1.city}")
      expect(page).to have_content("#{merchant_1.state}")
      expect(page).to have_content("#{merchant_1.zipcode}")
      expect(page).to have_content("#{merchant_1.email}")
    end
    it 'should redirect me to their profile if they are a regular user' do
      admin = create(:admin)
      user_1 = create(:user)

      post_login(admin)

      visit admin_merchant_path(user_1)
      expect(current_path).to eq(admin_user_path(user_1))
    end
  end
end
