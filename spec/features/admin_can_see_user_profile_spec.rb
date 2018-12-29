
require 'rails_helper'


  describe 'As an admin' do
    context 'visiting a user profile page' do
      it 'sees all the information a user would see' do

        admin_1 = create(:admin)
        user_1 = create(:user, role: 0)
          allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

        visit admin_user_path(user_1)

        expect(page).to have_content(user_1.name)
        expect(page).to have_content(user_1.address)
        expect(page).to have_content(user_1.city)
        expect(page).to have_content(user_1.state)
        expect(page).to have_content(user_1.zipcode)
        expect(page).to have_content(user_1.email)
        expect(page).not_to have_content(user_1.password)
        expect(page).to have_content(user_1.role)
        expect(page).to have_link("View My Items", href: dashboard_items_path)
      end
    end
  end
