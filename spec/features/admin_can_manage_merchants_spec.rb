require 'rails_helper'

describe 'As an admin user' do
  describe 'When I visit the merchants index page at merchants' do
    it 'should see all merchants in the system with a link to their dashboard' do
      merchants = create_list(:merchant, 2)
      admin = create(:admin)
      post_login(admin)

      visit merchants_path

      expect(page).to have_content(merchants[0].name)
      expect(page).to have_content(merchants[0].city)
      expect(page).to have_content(merchants[0].state)
      expect(page).to have_content(merchants[1].name)
      expect(page).to have_content(merchants[1].city)
      expect(page).to have_content(merchants[1].state)

      expect(page).to have_css("a#merchant-name-#{merchants[0].id}")
      expect(page).to have_css("a#merchant-name-#{merchants[1].id}")
    end
    it 'can see a can disable and enable merchants based on current status' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant, :disabled)
      admin = create(:admin)

      post_login(admin)

      visit merchants_path

      within "#merchant-#{merchant_1.id}" do
        expect(page).to have_css("input.disable")
      end
      within "#merchant-#{merchant_2.id}" do
        expect(page).to have_css("input.enable")
      end
    end
    it 'can click merchants name and be directed via /admin/merchants/id to merchant dashboard' do
      merchant = create(:merchant)
      admin = create(:admin)
      post_login(admin)

      visit merchants_path

      click_link(merchant.name)

      expect(current_path).to eq(admin_merchant_path(merchant))
    end
  end
end








# I see all merchants in the system
# Next to each merchant's name I see their city and state
# The merchant's name is a link to their Merchant Dashboard at routes such as "/admin/merchants/5"
# I see a "disable" button next to any merchants who are not yet disabled
# I see an "enable" button next to any merchants whose accounts are disabled
