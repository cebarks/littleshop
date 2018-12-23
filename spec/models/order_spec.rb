require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:status)}
    it {should have_many(:items).through(:order_items)}
    it {should have_many(:order_items)}
  end
  describe 'Relationships' do
    it { should belong_to(:user) }
  end
end
