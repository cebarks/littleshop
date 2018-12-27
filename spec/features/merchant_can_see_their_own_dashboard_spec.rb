require 'rails_helper'

describe 'A merchant who logs into our web app' do
  it 'can see a link to view items' do
    merchant_1 = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

    visit '/dashboard'
    expect(page).to have_link("view-merchant-items", :href => '/dashboard/items')

    click_link("view-merchant-items")
    expect(current_path).to eq(dashboard_items_path)
  end
  it 'shows all my items' do
    merchant_1 = create(:user, role: 1)
    item_1 = create(:item, user: merchant_1)
    item_2 = create(:item, user: merchant_1)
    item_3 = create(:item, user: merchant_1)
    item_4 = create(:item, user: merchant_1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

    visit dashboard_items_path
    expect(page).to have_content("#{item_1.name}")
    expect(page).to have_content("Quantity in stock: #{item_1.inventory_qty}")
  end
end
