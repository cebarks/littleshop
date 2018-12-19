require 'rails_helper'

  describe 'on a users own profile page' do
    context 'a user' do
      it 'can see all their own information excluding password' do

        user_1 = User.create(name: "John", address: "123 Main St", city: "Charleston", state: "Indiana", zipcode: 98765, email: "John@example.com", password: "secret123")

        visit user_path(user_1.id)

        expect(page).to have_content(user_1.name)
        expect(page).to have_content(user_1.address)
        expect(page).to have_content(user_1.city)
        expect(page).to have_content(user_1.state)
        expect(page).to have_content(user_1.zipcode)
        expect(page).to have_content(user_1.email)
        expect(page).not_to have_content(user_1.password)

      end

      it 'can see a link to edit profile' do
        user_1 = User.create(name: "John", address: "123 Main St", city: "Charleston", state: "Indiana", zipcode: 98765, email: "John@example.com", password: "secret123")

        visit user_path(user_1.id)

        expect(page).to have_content(user_1.name)
        expect(page).to have_content(user_1.address)
        expect(page).to have_content(user_1.city)
        expect(page).to have_content(user_1.state)
        expect(page).to have_content(user_1.zipcode)
        expect(page).to have_content(user_1.email)

        click_link("Edit Information")

        expect(current_path).to eq(edit_profile_path(user_1.id))
      end
    end
  end
