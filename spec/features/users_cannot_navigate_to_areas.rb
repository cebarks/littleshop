require 'rails_helper'

describe 'as a visitor to the the app i should get a 404 error' do
  it 'navigates to any /profile path' do
    visit profile_path
    expect(page).to have_http_status(404)
    expect(view).to render_template('pubic/404')

    visit profile_edit_path
    expect(page).to have_http_status(404)

    visit profile_order_path(1)
    expect(page).to have_http_status(404)
  end
  it 'navigates to any /dashboard_path' do
    visit dashboard_path
    expect(page).to have_http_status(404)

    visit dashboard_items_path
    expect(page).to have_http_status(404)
  end
  it 'navigates to any /admin_path' do
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
