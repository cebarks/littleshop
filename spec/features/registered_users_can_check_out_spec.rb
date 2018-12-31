require 'rails_helper'

RSpec.describe "As a registered user" do
  describe "When I add items to my cart and I visit my cart" do
    before(:each) do
      @user = create(:user)
      @item = create(:item)

      post_login(@user)

      visit item_path(@item)

      click_on 'Add To Cart'

      visit cart_path
    end

    it "I see a button indicating I can check out" do
      expect(page).to have_button('Check Out')
    end

    describe "When I click on the button to checkout" do
      before(:each) do
        click_on 'Check Out'
      end

      it "I am taken to my orders page ('/profile')" do
        expect(current_path).to eq(profile_path)
      end

      it "I see a flash message telling me my order was created" do
        within "#flashes" do
          expect(page).to have_content("Your has been created! Thank you for your business!")
        end
      end

      it "I see my new order listed on my profile page" do
        within ".orders-table" do
          within "#order-0" do
            within ".order-status" do
              expect(page).to have_content('pending')
            end

            within ".order-grand-total" do
              expect(page).to have_content(@item.price)
            end
          end
        end
      end
    end
  end
end


# As a registered user
# When I add items to my cart
# And I visit my cart
# I see a button or link indicating that I can check out
# And I click the button or link to check out
# An order is created in the system, which has a status of "pending"
# I am taken to my orders page ("/profile")
# I see a flash message telling me my order was created
# I see my new order listed on my profile page
