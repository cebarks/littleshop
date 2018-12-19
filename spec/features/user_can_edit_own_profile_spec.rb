require 'rails_helper'

describe 'as a registered user' do
  describe 'when i visit my profile page' do
    it 'should see a link to edit profile date' do
      registered_user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(registered_user)

      visit user_path(registered_user)

      click_link("Edit Information")
      #this needs to be change once current user is implemented
      expect(current_path).to eq(edit_profile_path(registered_user))
      expect(page).to have_css("#user-form")
      email = "maryg@gmail.com"

      fill_in :user_email, with: email

      click_on("Update User")

      expect(current_path).to eq(user_path(registered_user))
      save_and_open_page
      expect(page).to have_content(email)
    end
  end
end
