require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Validations' do
    it {should belong_to(:order)}
    it {should belong_to(:item)}
    it {should validate_presence_of(:order)}
    it {should validate_presence_of(:item)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:quantity)}
  end
end
