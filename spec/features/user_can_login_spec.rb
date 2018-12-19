require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when i visit the login path" do
    it "sees a field to enter my email and password" do
      email = "email1@gmail.com"
      password = "123"
      user = create(:user, email: email, password: password)

      visit login_path

      fill_in :user_email, with: email
      fill_in :user_password, with: password

      click_on "Log In"

      expect(current_path).to eq(profile_path)
    end
  end
end
