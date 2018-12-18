require 'rails_helper'

describe 'as any user in the system' do
  describe 'when i visit an items show page from the items catalogue' do
    #need to add image!
    xit 'should see all the information for that particular item except for image' do
      merchant_1 = create(:user, role: 1)
      item = create(:item, user_id: merchant_1.id)

      visit item_path(item)

      expect(page).to have_content(item.name)
      expect(page).to have_content(item.description)
      expect(page).to have_content(item.inventory_qty)
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content(item.price)
      expect(page).to have_content(item.email)
    end
  end
end
