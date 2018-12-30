require 'rails_helper'

  describe 'As an admin' do
    context 'visiting a user profile page' do
      it 'sees all the information a user would see' do

        admin_1 = create(:admin)
        merchant_1 = create(:merchant)
        user_1 = create(:user)
        order_1 = create(:order, user: user_1)
        item_1 = create(:item, user: merchant_1)
        OrderItem.create(item: item_1, order: order_1, quantity: 5, price: 100)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_1)

        visit admin_user_path(user_1)

        expect(page).to have_content(user_1.name)
        expect(page).to have_content(user_1.address)
        expect(page).to have_content(user_1.city)
        expect(page).to have_content(user_1.state)
        expect(page).to have_content(user_1.zipcode)
        expect(page).to have_content(user_1.email)
        expect(page).not_to have_content(user_1.password)
        expect(page).to have_content(user_1.role)
        expect(page).to_not have_link("View My Items", href: dashboard_items_path)

        within("#profile-orders") do
          expect(page).to have_css(".orders-table")
          expect(page).to have_content(order_1.id)
        end
      end
    end
  end
