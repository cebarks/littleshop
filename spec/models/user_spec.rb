require 'rails_helper'

describe User, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zipcode)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should have_many(:items)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_numericality_of(:zipcode)}
  end
  describe 'Class methods'do
    it '.merchants should return a list of only merchants' do
      merchant_1 = create(:merchant)
      create(:user)
      all_merchants = [merchant_1]

      expect(User.merchants).to eq(all_merchants)
    end
    it '.enabled_merchant should return enabled merchants' do
      merchant_1 = create(:merchant)
      create(:merchant, :disabled)

      expect(User.enabled_merchants).to eq([merchant_1])
    end
  end
  describe 'instance methods' do
    describe '.active_items' do
      it 'should return a list of only active items' do
        merchant_1 = create(:merchant)
        item_1 = create(:item, user: merchant_1, status: true)
        create(:item, user: merchant_1, status: false)
        current_active_items = [item_1]

        expect(merchant_1.active_items).to eq(current_active_items)
      end
    end
  end
end
