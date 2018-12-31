require 'rails_helper'

RSpec.describe "As an admin user" do
  describe "If I visit a profile page for a user that is a merchant" do
    it "I am redirected to their merchant dashboard instead" do
      admin = create(:admin)
      merchant = create(:merchant)

      post_login admin

      visit admin_user_path(merchant)

      expect(current_path).to eq(admin_merchant_path(merchant))
    end
  end
end
