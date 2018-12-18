require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When i visit the mmerchant users index page at " do
    before(:each) do
      @merchant_1 = create(:user, role: 1)
      @merchant_2 = create(:user, role: 0)
    end

    it "can see all merchants in the system who are active" do
      visit merchants_path

      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end

    it "next to each merchant's name I see their city, state, and register date" do
      visit merchants_path

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_1.city)
      expect(page).to have_content(@merchant_1.state)
      expect(page).to have_content(@merchant_1.created_at)
    end
  end
end
