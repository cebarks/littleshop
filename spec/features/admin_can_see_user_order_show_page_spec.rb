require 'rails_helper'

describe 'As an admin user when I visit a users profile and I click on a link for orders show page' do
  before(:each) do
    @admin = create(:admin)
    @user_1 = create(:user)
    @order_1 = create(:order, user: @user_1)

    post_login(@admin)

    visit admin_user_path(@user_1)

    within "#order-0" do
      click_on @order_1.id
    end
  end

  it ' URL route should be /admin/orders/id' do

  expect(current_path).to eq(admin_order_path(@order_1))
  end
  it 'should see all information about the order' do
    visit admin_order_path(@order_1)

    expect(page).to have_content(@order_1.id)
    expect(page).to have_content(@order_1.created_at)
    expect(page).to have_content(@order_1.updated_at)
    expect(page).to have_content(@order_1.status)
  end
  it 'should see all the items and their information' do
    expect(page).to have_content(@order_1.id)
    expect(page).to have_content(@order_1.created_at)
    expect(page).to have_content(@order_1.updated_at)
    expect(page).to have_content(@order_1.status)
    expect(page).to have_content(@order_1.total_quantity)
    expect(page).to have_content(@order_1.grand_total)

    @order_1.order_items.each_with_index do |order_item, index|
      within "#item-#{index}" do
        expect(page).to have_content(order_item.item.name)
        expect(page).to have_content(order_item.item.description)
        expect(page.find(".item-thumb")['src']).to have_content(order_item.item.image_url)
        expect(page).to have_content(order_item.quantity)
        expect(page).to have_content("$#{order_item.price}")
        expect(page).to have_content("$#{order_item.subtotal}")
      end
    end
  end
end









# each item the user ordered, including name, description, thumbnail, quantity, price and subtotal
# the total quantity of items in the whole order
# the grand total of all items for that order
