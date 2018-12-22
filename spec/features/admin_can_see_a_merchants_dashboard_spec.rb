require 'rails_helper'

describe 'As an admin user' do
  describe 'When I visit the merchants index page /merchants' do
    it 'should be able to click the link of each merchants name' do
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
  describe 'When I visit the merchants index page /merchants' do
    describe 'I click the linked name and am taken to admin/merchants/id' do
      it 'should be shown the same as a merchants dashboard' do
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
    end
  end
end
