require 'rails_helper'

describe 'as any user in the system' do
  describe 'when i visit an items show page from the items catalogue' do
    it 'should see all the information for that particular item except for image' do
      create(:merchant)
      item_1 = create(:item)
      order_1 = Order.create!(status: 3)
      OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)


      visit item_path(item_1)

      expect(page).to have_content(item_1.name)
      expect(page).to have_content("Description: #{item_1.description}")
      expect(page).to have_content("Quantity Remaining: #{item_1.inventory_qty}")
      expect(page).to have_content("Merchant: #{item_1.user.name}")
      expect(page).to have_content("Price: $#{item_1.price}")
    end
    it 'should see the average amount of time it takes a user-merchant to fulfill' do
      item_1 = create(:item)
      order_1 = Order.create!(status: 3, created_at: 2.days.ago)
      order_2 = Order.create!(status: 3, created_at: 3.days.ago)
      order_3 = Order.create!(status: 3, created_at: 5.days.ago)

      oi_1 = OrderItem.create!(item: item_1, order: order_1, quantity: 1, price: 1)
      oi_1 = OrderItem.create!(item: item_1, order: order_2, quantity: 1, price: 1)
      oi_1 = OrderItem.create!(item: item_1, order: order_3, quantity: 1, price: 1)

      visit item_path(item_1)

      expect(page).to have_content("Average Time to Fulfill: #{item_1.average_fulfillment_time} days.")
    end
  end
end
