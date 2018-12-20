require 'rails_helper'

describe 'on a users profile page' do
  describe 'a user' do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit profile_path
    end
    it 'can see all their own information excluding password' do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.address)
      expect(page).to have_content(@user.city)
      expect(page).to have_content(@user.state)
      expect(page).to have_content(@user.zipcode)
      expect(page).to have_content(@user.email)
      expect(page).not_to have_content(@user.password)

    end

    it 'can see a link to edit profile' do
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user.address)
      expect(page).to have_content(@user.city)
      expect(page).to have_content(@user.state)
      expect(page).to have_content(@user.zipcode)
      expect(page).to have_content(@user.email)

      expect(page).to have_content("Edit Information")
    end
  end
end
