require 'rails_helper'

describe 'A merchant who visits our web app' do
  describe 'when all order items from a single order are fulfilled by its respective merchants' do
    it 'shows a changed order status' do
      customer_1 = create(:user)
      order_1 = create(:order, :pending, user: customer_1, items_count: 0)
      merchant_1 = create(:merchant)
      item_1 = create(:item, inventory_qty: 999, user: merchant_1)
      item_2 = create(:item, inventory_qty: 999, user: merchant_1)
      OrderItem.create(order: order_1, item: item_1, quantity: 1, price: 1000, fulfillment: true)
      OrderItem.create(order: order_1, item: item_2, quantity: 1, price: 99)
      post_login(merchant_1)


      visit dashboard_path
      click_on order_1.id
      click_button "Fulfill"

      order_1.reload
      expect(order_1.status).to eq("complete")

    end
  end
  describe 'when visiting an order show page from their dashboard' do
    before(:each) do
      @customer_1 = create(:user)
      @order_1 = create(:order, :pending, user: @customer_1, items_count: 0)
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, inventory_qty: 100, user: @merchant_1)
      @item_2 = create(:item, inventory_qty: 5, user: @merchant_1)
      OrderItem.create(order: @order_1, item: @item_1, quantity: 50, price: 5543905)
      OrderItem.create(order: @order_1, item: @item_2, quantity: 10, price: 99)
      post_login(@merchant_1)

      visit dashboard_path
      click_on @order_1.id
    end
    describe 'if merchant has enough stock to fulfill an unfulfilled order' do
      it 'displays a fulfill button' do
        expect(page).to have_css("#fulfillment-button")
      end
    end
      scenario 'if button is clicked' do
        click_button "Fulfill"
        expect(current_path).to eq(dashboard_order_path(@order_1))
        expect(OrderItem.first.fulfillment).to eq(true)
        expect(page).to have_content("The item has been fulfilled.")
        @item_1.reload
        expect(@item_1.inventory_qty).to eq(50)
      end
    describe 'if merchant does not have enough stock to fulfill an unfilfilled order' do
      it 'shows a custom error message' do

        within("#item-1") do
          expect(page).to have_content("Not enough stock!")
        end
      end
    end
  end
end
