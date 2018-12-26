require 'rails_helper'

describe 'As an admin user when I visit the user index page' do
  describe 'And I click on a "disable" button for an enabled user' do
    it 'I am returned to the admins user index page' do
      admin = create(:admin)
      user = create(:user, role: 0)

      post_login(admin)

      visit admin_users_path

      click_on "Disable"

      expect(current_path).to eq(admin_users_path)

      within "#user-#{user.id}" do
        expect(page).to have_css("input.enable")
        expect(page).to_not have_css("input.disable")
      end
      expect(page).to have_content("#{user.name}'s account has been disabled!")
    end
    describe 'And I click on an "enable" button for an enabled user' do
      it 'I am returned to the admins user index page' do
        admin = create(:admin)
        user_2 = create(:user, :disabled)

        post_login(admin)

        visit admin_users_path

        click_on "Enable"

        expect(current_path).to eq(admin_users_path)

        within "#user-#{user_2.id}" do
          expect(page).to_not have_css("input.enable")
          expect(page).to have_css("input.disable")
        end
        expect(page).to have_content("#{user_2.name}'s account has been enabled!")
      end
    end
  end
end
