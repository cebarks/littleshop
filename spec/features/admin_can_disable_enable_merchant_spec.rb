require 'rails_helper'

RSpec.describe "As an admin" do
  describe "when I visit the merchant index page and I click on a 'disable' button for an enabled merchant" do
    before(:each) do
      @admin = create(:admin)
      @merchant = create(:merchant)
    end

    it "I am returned to the admin's merchant page" do
      visit admin_merchants_path

      within "#merchant-0" do
        click_on 'Disable'
      end

      expect(current_path).to eq(admin_merchants_path)
    end

    it "and I see a flash message that the merchant is disabled along with the account showing disabled" do
      visit admin_merchants_path

      within "#merchant-0" do
        click_on 'Disable'
      end

      expect(page).to have_content("#{@merchant.name}'s account has been disabled!")

      within "#merchant-0" do
        expect(page).to have_content("Disabled")
      end
    end

    it "the disabled merchant can not login" do
      merchant = create(:merchant, :disabled)

      post_login(merchant)
      expect(current_path).to eq(login_path)
      expect(page).to have_content("Your account has been disabled by an administrator.")
    end
  end

  describe "when I visit the merchant index page and I click on a 'enable' button for an disabled merchant" do
    before(:each) do
      @admin = create(:admin)
      @merchant = create(:merchant, :disabled)

      visit admin_merchants_path

      within "#merchant-0" do
        click_on 'Enable'
      end
    end

    it "I am returned to the admin's merchant page" do
      expect(current_path).to eq(admin_merchants_path)
    end

    it "and I see a flash message that the merchant is enabled along with the account showing enabled" do
      expect(page).to have_content("#{@merchant.name}'s account has been enabled!")
      within "#merchant-0" do
        expect(page).to have_content("Enabled")
      end
    end
  end
end


# As an admin merchant
# When I visit the merchant index page
# And I click on a "disable" button for an enabled merchant
# I am returned to the admin's merchant index page
# And I see a flash message that the merchant's account is now disabled
# And I see that the merchant's account is now disabled
# This merchant cannot log in
