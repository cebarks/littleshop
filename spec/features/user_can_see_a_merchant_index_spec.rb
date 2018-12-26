require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When i visit the merchant users index page" do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant, :disabled)
      visit merchants_path
    end

    it "can see all merchants in the system who are active" do
      within(".merchant-list") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
      end
    end

    it "next to each merchant's name I see their city, state, and register date" do
      within(".merchant-list") do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_1.city)
        expect(page).to have_content(@merchant_1.state)
        expect(page).to have_content(@merchant_1.created_at)
      end
    end
  end
end
