require 'rails_helper'

describe Item, type: :model do
  describe 'Class methods' do
    describe '.active_items' do
      it 'should return a list of only active items' do
        merchant_1 = Merchant.create(name: "Merchant 1", city: "City 1", state: "State 1")
        merchant_2 = Merchant.create(name: "Merchant 2", city: "City 2", state: "State 2")
        item_1 = merchant_1.items.create(name: "item 1", description: "glitter 1", image_url: "https://bit.ly/2rGOSMR", inventory_qty: 7, price: "5", status: true)
        item_2 = merchant_1.items.create(name: "item 2", description: "glitter 2", image_url: "https://bit.ly/2rGOSMR", inventory_qty: 9, price: "6", status: true)
        item_3 = merchant_2.items.create(name: "item 3", description: "glitter 3", image_url: "https://bit.ly/2rGOSMR", inventory_qty: 11, price: "7", status: false)
        item_4 = merchant_2.items.create(name: "item 4", description: "glitter 4", image_url: "https://bit.ly/2rGOSMR", inventory_qty: 12, price: "9", status: true)
        current_active_items = [item_1, item_2, item_4]

        expect(Item.active_items).to eq(current_active_items)
      end
    end
  end
end
