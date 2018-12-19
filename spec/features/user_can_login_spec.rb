require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when i visit the login path" do
    describe "sees a field to enter my email and password" do
      it "and I can log in as a regular user or visitor" do
        email = "email1@gmail.com"
        password = "123"
        create(:user, email: email, password: password)

        visit login_path

        fill_in :user_email, with: email
        fill_in :user_password, with: password

        click_on "Log In"

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("You are now logged in!")
      end
      it 'will be directed to my merchant dashboard if im a merchant' do
        email = "email1@gmail.com"
        password = "123"
        create(:user, email: email, password: password, role: 1)

        visit login_path

        fill_in :user_email, with: email
        fill_in :user_password, with: password

        click_on "Log In"

        expect(current_path).to eq(dashboard_path)
      end
      it 'will be directed to home page if im an admin' do
        email = "email1@gmail.com"
        password = "123"
        create(:user, email: email, password: password, role: 2)

        visit login_path

        fill_in :user_email, with: email
        fill_in :user_password, with: password

        click_on "Log In"

        expect(current_path).to eq(root_path)
      end
    end
    describe 'as a user if i visit the login page' do
      it "should be redirected to the login page if invalid credentials" do
        email = "email1@gmail.com"
        password = "123"
        create(:user, email: email, password: password, role: 2)

        visit login_path

        fill_in :user_email, with: email
        fill_in :user_password, with: password + "726"

        click_on "Log In"

        expect(current_path).to eq(login_path)
        expect(page).to have_content("Your credentials were incorrect!")
      end
    end
    describe 'as a logged in user if i visit the login path' do
      after(:each) do
        expect(page).to have_content("You are already logged in!")
      end
      it "should be redirected to the appropriate page" do
        email = "email1@gmail.com"
        password = "123"
        user_1 = create(:user, email: email, password: password)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

        visit login_path

        expect(current_path).to eq(profile_path)
      end
      it "should be redirected to the appropriate page" do
        email = "email1@gmail.com"
        password = "123"
        user_1 = create(:user, email: email, password: password, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

        visit login_path

        expect(current_path).to eq(dashboard_path)
      end
      it "should be redirected to the appropriate page" do
        email = "email1@gmail.com"
        password = "123"
        user_1 = create(:user, email: email, password: password, role: 2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

        visit login_path

        expect(current_path).to eq(root_path)
      end
    end
  end
end
