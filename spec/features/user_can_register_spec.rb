require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "When I click the 'register' link in the nav bar" do
    before(:each) do
      visit root_path
      click_on 'Register'
    end

    it "I am on the user registration page" do
      expect(current_path).to eq(register_path)
    end

    it "I can fill out a form to create a new user" do
      name = "John Shanny"
      address = "111 Broadyway St"
      city = "Denver"
      state = "Colorado"
      zipcode = "11111"
      email = "test1@gmail.com"
      password = "password123"

      fill_in :user_name, with: name
      fill_in :user_address, with: address
      fill_in :user_city, with: city
      fill_in :user_state, with: state
      fill_in :user_zipcode, with: zipcode
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_confirm_password, with: password

      click_on 'Create User'

      expect(current_path).to eq(profile_path)
      expect(page).to have_content("You have been registered and are now logged in!")
      expect(page).to have_content(name)
      expect(page).to have_content(address)
    end

    it "requires a unqiue email to sign up" do
      name = "John Shanny"
      address = "111 Broadyway St"
      city = "Denver"
      state = "Colorado"
      zipcode = "11111"
      email = "test1@gmail.com"
      password = "password123"

      User.create!(name: name, address: address, city: city, state: state, zipcode: zipcode, email: email, password: password)

      fill_in :user_name, with: name
      fill_in :user_address, with: address
      fill_in :user_city, with: city
      fill_in :user_state, with: state
      fill_in :user_zipcode, with: zipcode
      fill_in :user_email, with: email
      fill_in :user_password, with: password
      fill_in :user_confirm_password, with: password

      click_on 'Create User'

      expect(current_path).to_not eq(profile_path)
      expect(current_path).to eq(register_path)

      expect(page).to have_content("An error occured!")
      expect(page).to_not have_content(name)
      expect(page).to_not have_content(address)
    end
  end
end
