require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when i visit the login path' do
    before(:each) do
      @user = create(:user)
      @merchant = create(:merchant)
      @admin = create(:admin)
    end
    describe 'sees a field to enter my email and password' do
      before(:each) do
        visit login_path
      end

      it 'and I can log in as a regular user or visitor' do
        fill_in :user_email, with: @user.email
        fill_in :user_password, with: @user.password

        click_on 'Log In'

        expect(current_path).to eq(profile_path)
        expect(page).to have_content('You are now logged in!')
      end

      it 'will be directed to my merchant dashboard if im a merchant' do
        fill_in :user_email, with: @merchant.email
        fill_in :user_password, with: @merchant.password

        click_on 'Log In'

        expect(current_path).to eq(dashboard_path)
      end

      it 'will be directed to home page if im an admin' do
        fill_in :user_email, with: @admin.email
        fill_in :user_password, with: @admin.password

        click_on 'Log In'

        expect(current_path).to eq(root_path)
      end
      describe 'as a user if i visit the login page' do
        it 'should be redirected to the login page if invalid credentials' do
          fill_in :user_email, with: @user.email
          fill_in :user_password, with: @user.password + '726'

          click_on 'Log In'

          expect(current_path).to eq(login_path)
          expect(page).to have_content('Your credentials were incorrect!')
        end
      end
      describe 'as a disabled user if i visit the login page' do
        it 'should be not be allowed to login' do
          user_1 = create(:user, :disabled)
          fill_in :user_email, with: user_1.email
          fill_in :user_password, with: user_1.password

          click_on 'Log In'

          expect(current_path).to eq(login_path)
          expect(page).to have_content("Your account has been disabled by an administrator.")
        end
      end
      describe 'as a re-enabled user if i visit the login page' do
        it 'should be able to login' do
          user = create(:user, :disabled)
          admin_1 = create(:admin)

          post_login(admin_1)

          visit admin_users_path

          click_on "Enable"

          click_on "Logout"

          visit login_path

          fill_in :user_email, with: user.email
          fill_in :user_password, with: user.password

          click_on 'Log In'

          expect(current_path).to eq(profile_path)
          expect(page).to have_content("You are now logged in")
        end
      end
    end
    describe 'as a logged in user if i visit the login path' do
      after(:each) do
        expect(page).to have_content('You are already logged in!')
      end
      it 'should be redirected to the appropriate page' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

        visit login_path

        expect(current_path).to eq(profile_path)
      end

      it 'should be redirected to the appropriate page' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant)

        visit login_path

        expect(current_path).to eq(dashboard_path)
      end

      it 'should be redirected to the appropriate page' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

        visit login_path

        expect(current_path).to eq(root_path)
      end
    end
  end
end
