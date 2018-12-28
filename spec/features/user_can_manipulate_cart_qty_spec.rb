require 'rails_helper'

describe 'As a visitor or registered user ' do
  describe 'when i view my cart and it contains items' do
      before(:each) do
        @merchant = create(:user, role: 1)
        @user = create(:user)
        @item_1 = create(:item, user: @merchant)
        @item_2 = create(:item, user: @merchant, inventory_qty: 2)
        order_1 = Order.create!(status: 3, created_at: 2.days.ago, user: @user)
        order_2 = Order.create!(status: 3, created_at: 3.days.ago, user: @user)
        OrderItem.create!(item: @item_1, order: order_1, quantity: 1, price: 1)
        OrderItem.create!(item: @item_2, order: order_2, quantity: 1, price: 1)
        visit item_path(@item_1)
        click_button('Add To Cart')

        visit item_path(@item_2)
        click_button('Add To Cart')

        visit cart_path
      end
      it 'shows a link to remove the item from the cart' do

        within("#item-#{@item_1.name}") do
          expect(page).to have_selector(:link_or_button, 'Delete Item')
        end

        within("#item-#{@item_2.name}") do
          expect(page).to have_selector(:link_or_button, 'Delete Item')
        end

        within("#item-#{@item_1.name}") do
          click_link('Delete Item')
        end
        expect(current_path).to eq(cart_path)

        expect(page).to_not have_content("#{@item_1.name}")

      end
      it 'has an add link that cannot increment the count beyond the merchants inventory size' do
        within("#item-#{@item_1.name}") do
          expect(page).to have_selector(:link_or_button, 'Add Another')
        end

        within("#item-#{@item_2.name}") do
          expect(page).to have_selector(:link_or_button, 'Add Another')
          click_link('Add Another')
        end
        expect(current_path).to eq(cart_path)

        within("#item-#{@item_2.name}") do
          expect(page).to have_content("Quantity Ordered: 2")
          click_link('Add Another')
        end

        expect(current_path).to eq(cart_path)

        within("#item-#{@item_2.name}") do
          expect(page).to have_content("Quantity Ordered: 2")
        end
      end
      it 'has a decrease link that cannot decrease the count beyond the merchants inventory size' do
        visit item_path(@item_2)
        click_button('Add To Cart')

        visit cart_path

        within("#item-#{@item_1.name}") do
          expect(page).to have_selector(:link_or_button, 'Decrease Quantity')
        end

        within("#item-#{@item_2.name}") do
          expect(page).to have_selector(:link_or_button, 'Decrease Quantity')
          click_link('Decrease Quantity')
        end

        expect(current_path).to eq(cart_path)

        within("#item-#{@item_2.name}") do
          expect(page).to have_content("Quantity Ordered: 1")
          click_link('Decrease Quantity')
        end

        expect(current_path).to eq(cart_path)

        expect(page).to_not have_content("#{@item_2.name}")
      end
    end
end
