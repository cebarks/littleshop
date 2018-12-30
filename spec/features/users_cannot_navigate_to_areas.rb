require 'rails_helper'

describe 'as a visitor to the the app i should get a 404 error' do
  it 'navigates to any /profile, /admin or /dashboard path' do
    paths = profile_path,
            profile_edit_path,
            profile_order_path(1),
            dashboard_path,
            dashboard_items_path,
            dashboard_items_path,
            admin_users_path,
            admin_user_path(1),
            admin_merchants_path,
            admin_merchants_path(1)

    paths.each do |path|
      visit path

      expect(page).to have_http_status(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end




  #   visit profile_path
    # expect(page).to have_http_status(404)
    # expect(page).to have_content("The page you were looking for doesn't exist")
    #
  #   visit profile_edit_path
  #   expect(page).to have_http_status(404)
  #   expect(page).to have_content("The page you were looking for doesn't exist")
  #
  #   visit profile_order_path(1)
  #   expect(page).to have_http_status(404)
  #   expect(page).to have_content("The page you were looking for doesn't exist")
  # end
  # it 'navigates to any /dashboard_path' do
  #   visit dashboard_path
  #   expect(page).to have_http_status(404)
  #
  #   visit dashboard_items_path
  #   expect(page).to have_http_status(404)
  # end
  # it 'navigates to any /admin_path' do
  #   visit admin_users_path
  #   expect(page).to have_http_status(404)
  #
  #   visit admin_user_path(1)
  #   expect(page).to have_http_status(404)
  #
  #   visit admin_merchants_path
  #   expect(page).to have_http_status(404)
  #
  #   visit admin_merchant_path(1)
  #   expect(page).to have_http_status(404)
  end
end
describe 'as a registered user to the the app i should get a 404 error' do
  it 'navigates to any /dashboard path' do
    user = create(:user)
    post_login(user)

    visit dashboard_path
    expect(page).to have_http_status(404)

    visit dashboard_items_path
    expect(page).to have_http_status(404)
  end
  it 'navigates to any /admin_path' do
    user = create(:user)
    post_login(user)

    visit admin_users_path
    expect(page).to have_http_status(404)

    visit admin_user_path(1)
    expect(page).to have_http_status(404)

    visit admin_merchants_path
    expect(page).to have_http_status(404)

    visit admin_merchant_path(1)
    expect(page).to have_http_status(404)
  end
end
describe 'as a merchant user to the the app i should get a 404 error' do
  it 'navigates to any /profile path' do
    merchant = create(:merchant)
    post_login(merchant)

    visit profile_path
    expect(page).to have_http_status(404)

    visit profile_edit_path
    expect(page).to have_http_status(404)

    visit profile_order_path(1)
    expect(page).to have_http_status(404)
  end
  it 'navigates to any /admin path' do
    merchant = create(:merchant)
    post_login(merchant)

    visit admin_users_path
    expect(page).to have_http_status(404)

    visit admin_user_path(1)
    expect(page).to have_http_status(404)

    visit admin_merchants_path
    expect(page).to have_http_status(404)

    visit admin_merchant_path(1)
    expect(page).to have_http_status(404)
  end
  it 'navigates to any /cart path' do
    merchant = create(:merchant)
    post_login(merchant)

    visit cart_path
    expect(page).to have_http_status(404)

    visit carts_path
    expect(page).to have_http_status(404)
  end
end
describe 'as an admin user to the the app i should get a 404 error' do
  it 'navigates to any /profile path' do
    admin = create(:admin)
    post_login(admin)

    visit profile_path
    expect(page).to have_http_status(404)

    visit profile_edit_path
    expect(page).to have_http_status(404)

    visit profile_order_path(1)
    expect(page).to have_http_status(404)
  end
  it 'navigates to any /dashboard path' do
    admin = create(:admin)
    post_login(admin)

    visit dashboard_path
    expect(page).to have_http_status(404)

    visit dashboard_items_path
    expect(page).to have_http_status(404)
  end
  it 'navigates to any /cart path' do
    admin = create(:admin)
    post_login(admin)

    visit cart_path
    expect(page).to have_http_status(404)

    visit carts_path
    expect(page).to have_http_status(404)
  end
end
