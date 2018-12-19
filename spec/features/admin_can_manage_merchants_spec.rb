require 'rails_helper'

RSpec.describe "As an admin user" do
  describe "when i visit the merchant index page" do
    it "the merchant's name is a link to their dashboard" do
      merchant_1 = create(:user, role: 1)
      expect(page).to have_content(merchant_1.name)

      click_on merchant_1.name

      expect(current_path).to eq(admin_merchant_show)
    end
    it "there is an enable button next to any merchants that are disabled" do
      merchant_1 = create(:user, role: 1)

      within('#merchant-1') do
        expect(page).to have_selector("input[value='Disable']")
      end
    end
    it "there is an disable button next to any merchants that are enabled" do
      merchant_1 = create(:user, role: 1, status: false)
      within('#merchant-1') do
        expect(page).to have_selector("input[value='Enable']")
      end
    end
  end
end
