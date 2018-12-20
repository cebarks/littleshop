require 'rails_helper'

describe 'when any kind of user visits /items' do
  it 'should see all items except disabled ones' do
    item_1 = create(:item)
    item_2 = create(:item, :disabled)

    visit items_path


    within "#item-#{item_1.id}" do
      #need to add image
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_1.user.name)
      expect(page).to have_content("Quantity: #{item_1.inventory_qty} ")
      expect(page).to have_content("Price: $#{item_1.price} ")
    end

    expect(page).to_not have_content(item_2.name)
  end
  it 'should be able to click on the items name to see item show page' do
    item_1 = create(:item)
    order_1 = Order.create!(status: 3)
    OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)


    visit items_path

    click_link(item_1.name)

    expect(current_path).to eq(item_path(item_1))
  end
  it 'should be able to click on the items image to see item show page' do
    create(:merchant)
    item_1 = create(:item)
    order_1 = Order.create!(status: 3)
    OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)

    visit items_path

    page.find("a#drink-pic").click

    expect(current_path).to eq(item_path(item_1))
  end
  it 'shows statistics' do
    merchant_1 = create(:merchant)
    item_1, item_2, item_3, item_4, item_5, item_6, item_7, item_8, item_9, item_10 = create_list(:item, 10, user: merchant_1)

    order_1 = Order.create!(status: 1)

    OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)
    OrderItem.create!(item: item_2, order: order_1, quantity: 2, price: 2)
    OrderItem.create!(item: item_3, order: order_1, quantity: 4, price: 4)
    OrderItem.create!(item: item_4, order: order_1, quantity: 8, price: 44)
    OrderItem.create!(item: item_5, order: order_1, quantity: 16, price: 440)

    visit items_path

    expect(page).to have_content("5 Most Popular Items:\n#{item_5.name}\n#{item_4.name}\n#{item_3.name}\n#{item_2.name}\n#{item_1.name}")
    expect(page).to have_content("5 Least Popular Items:\n#{item_1.name}\n#{item_2.name}\n#{item_3.name}\n#{item_4.name}\n#{item_5.name}")
  end
end
