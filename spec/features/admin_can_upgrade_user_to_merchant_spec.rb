require 'rails_helper'

RSpec.describe "As an admin user" do
  describe "When I visit a user's profile page ('/admin/users/5')" do
    before(:each) do
      @user = create(:user)
      @admin = create(:admin)

      post_login(@admin)

      visit admin_user_path(@user)
    end

    it "I see a link to 'upgrade' the user's account to become a merchant" do
      expect(page).to have_link('Upgrade')
    end

    describe "When I click the 'upgrade' link" do
      before(:each) do
        click_on 'Upgrade'
      end

      it "I am redirected to ('/admin/merchants/5')" do
        expect(current_path).to eq(admin_merchant_path(@user))
      end

      it "I see a flash message indicating the user has been upgraded" do
        within "#flashes" do
          expect(page).to have_content("#{@user.email} has been upgraded to merchant status.")
        end
      end
    end
  end
end

# As an admin user
# When I visit a user's profile page ("/admin/users/5")
# I see a link to "upgrade" the user's account to become a merchant
# When I click on that link
# I am redirected to ("/admin/merchants/5") because the user is now a merchant
# And I see a flash message indicating the user has been upgraded
# The next time this user logs in they are now a merchant
# Only admins can see the "upgrade" link
# Only admins can reach any route necessary to upgrade the user to merchant status

RSpec.describe "As a regular user" do
  describe "When I visit a merchant's dashboard ('/admin/merchants/6')" do
    before(:each) do
      @user = create(:user)

      post_login(@user)
      visit admin_merchant_path(@user)
    end

    it "I do NOT see a link to 'upgrade' myself to a merchant user" do
      expect(page).to_not have_link("Upgrade")
    end

    it "I can not reach the route necessary to upgrade a user to a merchant user" do
      page.driver.submit :patch, admin_merchant_path(@user, role: :merchant), {}

      expect(page).to have_http_status(404)
    end
  end

  describe "That has been downgraded by an admin" do
    it "The next time I log in I am no longer an merchant" do
      user = create(:user)
      admin = create(:admin)

      post_login(admin)

      visit admin_user_path(user)

      click_on 'Upgrade'

      visit admin_users_path

      expect(page).to_not have_content(user.name)

      visit admin_user_path(user)
      expect(current_path).to eq(admin_merchant_path(user))

      visit logout_path

      visit login_path

      fill_in :user_email, with: user.email
      fill_in :user_password, with: user.password

      click_on "Log In"

      expect(current_path).to eq(dashboard_path)
      expect(page).to_not have_content("Authorization level: default")
      expect(page).to have_content("Authorization level: merchant")
    end
  end
end
