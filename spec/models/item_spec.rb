require 'rails_helper'
describe 'instance methods' do
  describe '.average_fulfillment_time' do
    it 'should return average fulfillment time for specific item' do
      merchant_1 = create(:user, role: 1)
      item_1 = create(:item, user: merchant_1)
      binding.pry

      full

    end
  end
end
