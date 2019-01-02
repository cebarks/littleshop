require 'rails_helper'

RSpec.describe "As an admin user" do
  describe "When I visit a merchant's dashboard ('/admin/merchants/6')" do
    before(:each) do
      @merchant = create(:merchant)
      @admin = create(:admin)

      post_login(@admin)
      visit admin_merchant_path(@merchant)
    end

    it "I see a link to 'downgrade' the merchant's account to become a regular user" do
      expect(page).to have_link("Downgrade")
    end

    describe "When I click the link to 'Downgrade'" do
      before(:each) do
        click_on 'Downgrade'
      end

      it "I am redirected to ('/admin/users/6') because the merchant is now a regular user" do
        expect(current_path).to eq(admin_user_path(@merchant))
      end

      it "I see a flash message indicating the user has been downgraded" do
        within "#flashes" do
          expect(page).to have_content("#{@merchant.email} has been downgraded to default user status.")
        end
      end
    end
  end
end

describe "It cannot be used by other user-roles/ render 404" do
  it "clicks on downgrade and a 404 is rendered" do
    merchant = create(:merchant)

    page.driver.submit(:patch, admin_merchant_path(merchant, redirect: :merch_index), {})

    expect(page.status_code).to eq(404)
    expect(page).to have_content("The page you were looking for doesn't exist.")
  end
end

RSpec.describe "As a merchant user" do
  describe "When I visit a merchant's dashboard ('/admin/merchants/6')" do
    before(:each) do
      @merchant = create(:merchant)

      post_login(@merchant)
      visit admin_merchant_path(@merchant)
    end
    it "I do NOT see a link to 'downgrade' myself to a regular user" do
      expect(page).to_not have_link("Downgrade")
    end

    it "I can not reach the route necessary to downgrade a merchant to a regular user" do
      page.driver.submit :patch, admin_merchant_path(@merchant, role: :user), {}

      expect(page).to have_http_status(404)
    end
  end

  describe "That has been downgraded by an admin" do
    it "The next time I log in I am no longer an merchant" do
      merchant = create(:merchant)
      admin = create(:admin)

      post_login(admin)

      visit admin_merchant_path(merchant)

      click_on 'Downgrade' # Should set merchant to be a 'default' user

      visit merchants_path

      expect(page).to_not have_content(merchant.name)

      visit admin_merchant_path(merchant)
      expect(current_path).to eq(admin_user_path(merchant))

      visit logout_path

      visit login_path

      fill_in :user_email, with: merchant.email
      fill_in :user_password, with: merchant.password

      click_on "Log In"

      expect(current_path).to eq(profile_path)
      expect(page).to_not have_content("Authorization level: merchant")
      expect(page).to have_content("Authorization level: default")
    end
  end
end
