require 'rails_helper'


  describe 'Class Methods' do
    it '.add_item' do
      cart = Cart.new({"1" => 2})
      cart.add_item(1)
      cart.add_item(9)

      expect(cart.contents).to eq({"1" => 3, "9" => 1})
    end

    it '.amount' do
      cart = Cart.new({"1" => 2, "15" => 30})

      expect(cart.amount(15)).to eq(30)
      expect(cart.amount(1)).to eq(2)
      expect(cart.amount(20)).to eq(0)
    end

    it '.total_count' do
      cart = Cart.new({"1" => 2, "15" => 30})

      expect(cart.total_count).to eq(32)
    end

  end
