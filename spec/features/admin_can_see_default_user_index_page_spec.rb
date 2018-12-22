require 'rails_helper'

describe 'As an admin user' do
  describe 'When I click the link users in the nav bar' do
    it 'should be directed to the admin_user_index page' do
      admin = create(:admin)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit root_path

      click_link("Browse All Users")

      expect(current_path).to eq(admin_users_path)
    end
  end
  describe 'When I click the link to visit the user index page at /admin/users' do
    it 'should see only see all default users' do
      user_1 = create(:user)
      user_2 = create(:user)
      merchant = create(:merchant)
      admin = create(:admin)

      post_login(admin)

      visit admin_users_path

      within "#user-#{user_1.id}" do
        expect(page).to have_content("Name: #{user_1.name}")
        expect(page).to have_content("Registered Since: #{user_1.created_at}")
      end
      within "#user-#{user_2.id}" do
        expect(page).to have_content("Name: #{user_2.name}")
        expect(page).to have_content("Registered Since: #{user_2.created_at}")
      end
      expect(page).to_not have_content(merchant.name)
    end
    it 'can see a can disable and enable merchants based on current status' do
      user_1 = create(:user)
      user_2 = create(:user, :disabled)
      admin = create(:admin)

      post_login(admin)

      visit admin_users_path

      within "#user-#{user_1.id}" do
        expect(page).to have_css("input.disable")
      end
      within "#user-#{user_2.id}" do
        expect(page).to have_css("input.enable")
      end
    end
  end
  describe 'When I click the link to visit the user index page at /admin/users' do
    it 'should be able to click each name and go to the admins user show page' do
      user_1 = create(:user)
      admin = create(:admin)

      post_login(admin)

      visit admin_users_path

      within "#user-#{user_1.id}" do
        click_link("#{user_1.name}")
      end

      expect(current_path).to eq(admin_user_path(user_1))
    end
  end
end
