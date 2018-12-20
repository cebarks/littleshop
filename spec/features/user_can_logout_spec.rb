require 'rails_helper'

describe 'as a user when i visit the logout path' do
  it 'is redirected to the root path with a logged out message' do
    user_1 = create(:user)

    page.driver.post(login_path, user_email: user_1.email, user_password: user_1.password)

    visit logout_path

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You are logged out!")
    expect(page).to have_content("Cart: 0")
    #this isn't real yet because we don't have a cart
  end
end
