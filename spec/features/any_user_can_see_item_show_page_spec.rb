require 'rails_helper'

describe 'as any user in the system' do
  describe 'when i visit an items show page from the items catalogue' do
    xit 'should see all the information for that particular item' do
      merchant_1 = create(:user, role: 1)
      item = create(:item)

      visit item_path(item)

      expect(page).to have_content(item.name)
      expect(page).to have_content(item.description)
      # expect(page).to have_content(item.city)
      expect(page).to have_content(item.inventory_qty)
      expect(page).to have_content(item.price)
      expect(page).to have_content(item.email)
    end
  end
end
