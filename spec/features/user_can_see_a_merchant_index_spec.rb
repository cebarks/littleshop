require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When i visit the marchant's index page at \"/merchants\"" do
    before(:each) do
      # FIXME: Merchants needs to have one that is active and one that is not
      @merchant_1 = Merchant.new(name: "test1", city: "Denver", state: "Colorado")
      @merchant_2 = Merchant.new(name: "test2", city: "Moab", state: "Utah")

      visit merchants_path
    end

    it "I see all merchants in the system who are active" do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to_not have_content(@merchant_2.name)
    end

    it "next to each merchant's name I see their city, state, and register date" do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_1.city)
      expect(page).to have_content(@merchant_1.state)
      expect(page).to have_content(@merchant_1.created_at)
    end
  end
end
