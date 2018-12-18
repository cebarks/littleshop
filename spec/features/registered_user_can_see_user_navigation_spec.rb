describe 'a registered user ' do
  it 'sees a registered user specific navigation bar' do

      user_1 = User.create(name: "John", address: "123 Main St", city: "Charleston", state: "Indiana", zipcode: 98765, email: "John@example.com", password: "secret123")
      allow_any_instance_of(User).to recieve(:current_user).and_return(registered_user)

      visit '/'

    within("#user-nav-bar") do
      expect(page).to have_content("Home")
      expect(page).to have_content("Browse Items")
      expect(page).to have_content("Browse Merchants")
      expect(page).to have_content("Cart(0)")
      expect(page).to have_content("Profile")
      expect(page).to have_content("#{User.name}'s Orders")
      expect(page).to have_content("Logout")


      expect(page).not_to have_content("Login")
      expect(page).not_to have_content("Register")

      expect(page).to have_content("Logged in as #{User.name}")
    end

    click_on 'home-link'
    expect(current_path).to eq('/')

    click_on 'items-link'
    expect(current_path).to eq(items_path)

    click_on 'merchants-link'
    expect(current_path).to eq(merchants_path)

    click_on 'register-link'
    expect(current_path).to eq('/register')

    click_on 'profile-link'
    expect(current_path).to eq('/profile')

    click_on 'user-orders-link'
    expect(current_path).to eq('/profile/orders')

    click_on 'logout-link'
    expect(current_path).to eq('/logout')

  end

end
