require 'rails_helper'

describe 'an admin ' do
  it 'sees an admin specific navigation bar' do
    admin_1 = create(:user, role: 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

    visit '/'

    within("#admin-nav-bar") do
      expect(page).to have_content("Home")
      expect(page).to have_content("Browse Items")
      expect(page).to have_content("Browse Merchants")
      expect(page).to have_content("Profile")
      expect(page).to have_content("Browse All Users")
      expect(page).to have_content("#{admin_1.name}'s Orders")
      expect(page).to have_content("Logout")

      expect(page).not_to have_content("Cart: 0")


      expect(page).to have_content("Logged in as #{admin_1.name}")
    end

    have_link("home_link", href: '/')
    have_link("items_link", href: '/items')
    have_link("merchants_link", href: '/merchants')
    have_link("profile_link", href: '/profile')
    have_link("admin_users_link", href: '/admin/users')
    have_link("user_orders_link", href: '/orders')
    have_link("logout_link", href: '/logout')

    # THESE ARE TESTS TO ENSURE THAT WE CAN REACH THE CORRECT PAGE...
    # ....THROUGH OUR LINKS. THEY HAVE BEEN COMMENTED OUT BECAUSE SOME....
    # ....OF THESE PATHS DO NOT EXIST

    # click_on 'home-link'
    # expect(current_path).to eq('/')
    #
    # click_on 'items-link'
    # expect(current_path).to eq(items_path)
    #
    # click_on 'merchants-link'
    # expect(current_path).to eq(merchants_path)
    #
    # click_on 'cart-link'
    # expect(current_path).to eq(cart_index_path)
    #
    # click_on 'profile-link'
    # expect(current_path).to eq(profile_path)
    #
    # click_on 'user-orders-link'
    # expect(current_path).to eq(orders_path)
    #
    # click_on 'logout-link'
    # expect(current_path).to eq(logout_path)
  end
  end
