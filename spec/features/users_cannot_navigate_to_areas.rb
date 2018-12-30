require 'rails_helper'

describe 'as a visitor to the the app i should get a 404 error' do
  it 'navigates to any /profile, /admin or /dashboard path' do
    paths = [profile_path,
            profile_edit_path,
            profile_order_path(1),
            dashboard_path,
            dashboard_items_path,
            admin_users_path,
            admin_user_path(1),
            admin_merchants_path,
            admin_merchants_path(1)]

    paths.each do |path|
      visit path

      expect(page).to have_http_status(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
describe 'as a registered user to the the app i should get a 404 error' do
  it 'navigates to any /admin or /dashboard path' do
    user = create(:user)
    post_login(user)

    paths = [dashboard_path,
            dashboard_items_path,
            admin_users_path,
            admin_user_path(1),
            admin_merchants_path,
            admin_merchants_path(1)]

    paths.each do |path|
      visit path

      expect(page).to have_http_status(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
describe 'as a merchant user to the the app i should get a 404 error' do
  it 'navigates to any /profile /admin or /cart path' do
    merchant = create(:merchant)
    post_login(merchant)

    paths = [profile_path,
            profile_edit_path,
            profile_order_path(1),
            admin_users_path,
            admin_user_path(1),
            admin_merchants_path,
            admin_merchants_path(1),
            cart_path,
            cart_paths]

    paths.each do |path|
      visit path

      expect(page).to have_http_status(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
describe 'as an admin user to the the app i should get a 404 error' do
  it 'navigates to any /profile /dashboard or /cart path' do
    admin = create(:admin)
    post_login(admin)

    paths = profile_path,
            profile_edit_path,
            profile_order_path(1),
            dashboard_path,
            dashboard_items_path,
            cart_path,
            cart_paths

    paths.each do |path|
      visit path

      expect(page).to have_http_status(404)
      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
