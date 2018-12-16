require 'rails_helper'

describe Merchant, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
  end
end
