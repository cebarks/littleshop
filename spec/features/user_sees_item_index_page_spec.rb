require 'rails_helper'

describe 'when any kind of user visits /items' do
  it 'should see all items except disabled ones' do
    item_1, item_2, item_3 = create_list(:item, 3)
    item_4 = create(:item, :disabled)

    visit items_path

    expect(page).to_not have_content(item_4.name)

    within "#item-#{item_1.id}" do
      #need to add image
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_1.user.name)
      expect(page).to have_content("Quantity: #{item_1.inventory_qty}")
      expect(page).to have_content("Price: $#{item_1.price}")
    end

    within "#item-#{item_2.id}" do
      #need to add image
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_2.user.name)
      expect(page).to have_content("Quantity: #{item_2.inventory_qty}")
      expect(page).to have_content("Price: $#{item_2.price}")
    end

    within "#item-#{item_3.id}" do
      #need to add image
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_3.user.name)
      expect(page).to have_content("Quantity: #{item_3.inventory_qty}")
      expect(page).to have_content("Price: $#{item_3.price}")
    end

    expect(page).to_not have_content(item_4.name)
    expect(page).to_not have_content(item_4.user.name)
    expect(page).to_not have_content("Quantity: #{item_4.inventory_qty}")
    expect(page).to_not have_content("Price: $#{item_4.price}")
  end
  it 'should be able to click on the items name to see item show page' do
    item_1 = create(:item)

    visit items_path

    click_link(item_1.name)

    expect(current_path).to eq(item_path(item_1))
  end
  it 'should be able to click on the items image to see item show page' do
    merchant_1 = create(:merchant)
    item_1 = merchant_1.items.create!(name: "item 1", description: "glitter 1", image_url: "https://bit.ly/2rGOSMR", inventory_qty: 7, price: "5", status: true)

    visit items_path

    page.find("a#drink-pic").click

    expect(current_path).to eq(item_path(item_1))
  end
  it 'shows statistics' do
    merchant_1 = create(:merchant)
    item_1, item_2, item_3, item_4, item_5, item_6, item_7, item_8, item_9, item_10 = create_list(:item, 10, user: merchant_1)

    order_1 = Order.create!(status: 1)
    order_2 = Order.create!(status: 1)

    OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)
    OrderItem.create!(item: item_2, order: order_1, quantity: 2, price: 2)
    OrderItem.create!(item: item_3, order: order_1, quantity: 4, price: 4)
    OrderItem.create!(item: item_4, order: order_1, quantity: 8, price: 44)
    OrderItem.create!(item: item_5, order: order_1, quantity: 16, price: 440)
    OrderItem.create!(item: item_6, order: order_2, quantity: 32, price: 4400)
    OrderItem.create!(item: item_7, order: order_2, quantity: 64, price: 9999)
    OrderItem.create!(item: item_8, order: order_2, quantity: 128, price: 22222)
    OrderItem.create!(item: item_9, order: order_2, quantity: 256, price: 40000)
    OrderItem.create!(item: item_10, order: order_2, quantity: 512, price: 85400)

    visit items_path

    expect(page).to have_content("5 Most Popular Items:\n#{item_10.name}\n#{item_9.name}\n#{item_8.name}\n#{item_7.name}\n#{item_6.name}")
    expect(page).to have_content("5 Least Popular Items:\n#{item_1.name}\n#{item_2.name}\n#{item_3.name}\n#{item_4.name}\n#{item_5.name}")
  end
end
