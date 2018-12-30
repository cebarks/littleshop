require 'rails_helper'

describe 'as a registered user' do
  describe 'when i visit my profile page' do
    it 'should see a link to edit profile date' do
      admin = create(:admin)
      registered_user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(registered_user)

      click_link("Edit Information")
      expect(current_path).to eq(edit_admin_user_path(registered_user))
      expect(page).to have_css("#user-form")

      name = "Hello"

      fill_in :user_name, with: name
      click_on("Update User")
      registered_user.reload
      expect(current_path).to eq(admin_user_path(registered_user))

      expect(page).to have_content(name)
      expect(page).to have_content("#{registered_user.name}'s account has been changed.")
    end
    it 'should have unique email' do
      admin = create(:admin)
      user_1, user_2 = create_list(:user, 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_user_path(user_1)

      click_link("Edit Information")

      expect(current_path).to eq(edit_admin_user_path(user_1))
      expect(page).to have_css("#user-form")

      fill_in :user_email, with: user_2.email
      click_on("Update User")

      expect(current_path).to eq(edit_admin_user_path(user_1))

      expect(page).to have_content("You have entered invalid changes. Please try again.")
    end
  end
end
