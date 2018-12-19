require 'rails_helper'

describe 'as a registered user' do
  describe 'when i visit my profile page' do
    it 'should see a link to edit profile date' do
      registered_user = create(:user)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(registered_user)

      visit user_path(registered_user)

      click_link("Edit Information")

      expect(current_path).to eq(edit_profile_path(registered_user))
    end
  end
end
