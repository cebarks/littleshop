require 'rails_helper'

describe 'As an admin user when I visit the user index page' do
  describe 'And I click on a "disable" button for an enabled user' do
    it 'I am returned to the admins user index page' do
      admin = create(:admin)
      user = create(:user, role: 0)

      post_login(admin)

      visit admin_users_path

      click_on "Disable"
      binding.pry
      expect(current_path).to eq(admin_users_path)

      within "#user-#{user.id}" do
        expect(page).to have_css("input.enable")
        expect(page).to_not have_css("input.disable")
      end
    end
  end
end







# And I see a flash message that the users account is now disabled
# And I see that the users account is now disabled
# This user cannot log in
