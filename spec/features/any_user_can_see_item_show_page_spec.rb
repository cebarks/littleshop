require 'rails_helper'

describe 'as any user in the system' do
  describe 'when i visit an items show page from the items catalogue' do
    #need to add image!
    it 'should see all the information for that particular item except for image' do
      merchant_1 = create(:user, role: 1)
      item = create(:item, user: merchant_1)

      visit item_path(item)

      expect(page).to have_content(item.name)
      expect(page).to have_content("Description: #{item.description}")
      expect(page).to have_content("Quantity Remaining: #{item.inventory_qty}")
      expect(page).to have_content("Merchant: #{item.user.name}")
      expect(page).to have_content("Price: $#{item.price}")

    end
  end
end
