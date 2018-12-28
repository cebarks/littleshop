require 'rails_helper'

describe 'instance methods' do
  it '.add_item should add an item' do
    merchant = create(:merchant)
    item_1 = create(:item, user: merchant)
    item_2 = create(:item, user: merchant)
    cart = Cart.new(Hash.new(0))
    cart.add_item(item_1)
    cart.add_item(item_1)
    cart.add_item(item_1)
    cart.add_item(item_2)

    expect(cart.contents).to eq({"#{item_1.id}" => 3, "#{item_2.id}" => 1})
  end

  it '.amount should return amount for each item' do
    merchant = create(:merchant)
    item_1 = create(:item, user: merchant)
    item_2 = create(:item, user: merchant)
    item_3 = create(:item, user: merchant)

    cart = Cart.new(Hash.new(0))
    cart.add_item(item_1)
    cart.add_item(item_1)
    cart.add_item(item_1)
    cart.add_item(item_2)
    cart.add_item(item_3)
    cart.add_item(item_3)

    expect(cart.item_amount(item_1)).to eq(3)
    expect(cart.item_amount(item_2)).to eq(1)
    expect(cart.item_amount(item_3)).to eq(2)
  end

  it '.total_count should return total count of all items' do
    cart = Cart.new({"1" => 2, "15" => 30})

    expect(cart.total_count).to eq(32)
  end

  it '.all_items should return all item objects in cart' do
    merchant = create(:merchant)
    item_1 = create(:item, user: merchant)
    item_2 = create(:item, user: merchant)
    cart = Cart.new(Hash.new(0))
    cart.add_item(item_1)
    cart.add_item(item_1)
    cart.add_item(item_1)
    cart.add_item(item_2)
    all_items_in_cart = ([item_1, item_2])

    expect(cart.all_items).to eq(all_items_in_cart)
  end
  describe 'it should return a subtotal for each item' do
    it '.item_subtotal' do
      merchant = create(:merchant)
      item_1 = create(:item, user: merchant, price: 5)
      item_2 = create(:item, user: merchant, price: 15)
      cart = Cart.new(Hash.new(0))
      cart.add_item(item_1)
      cart.add_item(item_1)
      cart.add_item(item_1)
      cart.add_item(item_2)
      item_1_subtotal = 15
      item_2_subtotal = 15

      expect(cart.item_subtotal(item_1)).to eq(item_1_subtotal)

      expect(cart.item_subtotal(item_2)).to eq(item_2_subtotal)
    end
  end
  describe 'it should return a grand total ' do
    it '.grand_total' do
      merchant = create(:merchant)
      item_1 = create(:item, user: merchant, price: 5)
      item_2 = create(:item, user: merchant, price: 15)
      cart = Cart.new(Hash.new(0))
      cart.add_item(item_1)
      cart.add_item(item_1)
      cart.add_item(item_1)
      cart.add_item(item_2)
      total = 30

      expect(cart.grand_total).to eq(total)
    end
  end
end
describe 'instance methods' do
  describe 'it should empty the cart of all items' do
    it '.empty' do
      merchant = create(:merchant)
      item_1 = create(:item, user: merchant, price: 5)
      item_2 = create(:item, user: merchant, price: 15)
      cart = Cart.new(Hash.new(0))
      cart.add_item(item_1)
      cart.add_item(item_2)
      final = ({})

      expect(cart.empty).to eq(final)
    end
  end
  describe 'it should remove one item' do
    it '.remove_item' do
      merchant = create(:merchant)
      item_1 = create(:item, user: merchant, price: 5)
      item_2 = create(:item, user: merchant, price: 15)
      cart = Cart.new(Hash.new(0))
      cart.add_item(item_1)
      cart.add_item(item_2)
      final = cart.remove_item(item_1.id)
      updated_cart = ({"#{item_2.id}"=>1})

      expect(final).to eq(updated_cart)
    end
  end
  describe 'it should increase an item by one until max inventory' do
    it '.increase_item_count' do
      merchant = create(:merchant)
      item_1 = create(:item, user: merchant, price: 5, inventory_qty: 2)
      item_2 = create(:item, user: merchant, price: 15)
      cart = Cart.new(Hash.new(0))
      cart.add_item(item_1)
      cart.add_item(item_2)
      total = cart.increase_item_count(item_1.id)
      updated_cart = ({"#{item_1.id}"=>2, "#{item_2.id}"=>1})

      expect(total).to eq(updated_cart)

      cart.increase_item_count(item_1.id)

      expect(total).to eq(updated_cart)
    end
  end
  describe 'it should decrease an item by one until inventory is 0' do
    it '.decrease_item_count' do
      merchant = create(:merchant)
      item_1 = create(:item, user: merchant, price: 5)
      item_2 = create(:item, user: merchant, price: 15)
      cart = Cart.new(Hash.new(0))
      cart.add_item(item_1)
      cart.add_item(item_2)
      total = cart.decrease_item_count(item_1.id)

      updated_cart = ({"#{item_2.id}"=>1})

      expect(total).to eq(updated_cart)

      cart.decrease_item_count(item_1.id)

      expect(total).to eq(updated_cart)
    end
  end
end
