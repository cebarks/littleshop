require 'rails_helper'

describe 'A merchant who logs into our web app' do
  describe 'when visiting an order show page from their dashboard' do
    before(:each) do
      @customer_1 = create(:user)
      @order_1 = create(:order, :pending, user: @customer_1)
      @merchant_1 = @order_1.items.first.user
      @item_2 = @order_1.items.second
      post_login(@merchant_1)

      visit dashboard_path
      click_on @order_1.id
    end
    it 'displays customer name and shipping address' do
      expect(page).to have_content(@customer_1.name)
      expect(page).to have_content(@customer_1.address)
      expect(page).to have_content(@order_1.items.first.price)
    end
    it 'only displays information about my products' do
      expect(page).to have_no_content(@item_2.name)
      expect(page).to have_no_content(@item_2.description)
    end
    it 'shows an image which is a link to item show' do
      page.html.should include(@order_1.items.first.image_url)
      click_on "View Item"
      expect(current_path).to eq(item_path(@order_1.items.first))
    end
  end
end
