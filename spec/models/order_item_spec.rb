require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Validations' do
    it {should belong_to(:order)}
    it {should belong_to(:item)}
  end
end
