require 'rails_helper'


  describe 'a merchant' do
    context 'on their items dashboard page' do
      it 'can see link to add new item' do
        merchant_1 = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

        visit 'dashboard/items'

        expect(page).to have_link("Add a new item", :href => '/items/new')

      end

      it 'can see all information for each item added to the system' do
        merchant_1 = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

        item_1 = merchant_1.items.create!(name: "Amaretto Sour", description: "a sweet nutty cocktail that calls for a full bodied spirit to pair with the bright citrus and sugar. di Amore Amaretto is an excellent choice with its rich body and caramel, almond flavors.", image_url: "https://bit.ly/2BoIMFi", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
        item_2 = merchant_1.items.create!(name: "Espresso Martini", description: "a cold, coffee-flavored cocktail made with vodka, espresso coffee, coffee liqueur, and sugar syrup.", image_url: "https://bit.ly/2A4XQYS", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))

        visit 'dashboard/items'

        expect(page).to have_content(item_1.id)
        expect(page).to have_content(item_1.name)
        expect(page).to have_content(item_1.image_url)
        expect(page).to have_content(item_1.price)
        expect(page).to have_content(item_1.inventory_qty)
      end

      it 'can see a link to edit items' do
        merchant_1 = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

        item_1 = merchant_1.items.create!(name: "Amaretto Sour", description: "a sweet nutty cocktail that calls for a full bodied spirit to pair with the bright citrus and sugar. di Amore Amaretto is an excellent choice with its rich body and caramel, almond flavors.", image_url: "https://bit.ly/2BoIMFi", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
        item_2 = merchant_1.items.create!(name: "Espresso Martini", description: "a cold, coffee-flavored cocktail made with vodka, espresso coffee, coffee liqueur, and sugar syrup.", image_url: "https://bit.ly/2A4XQYS", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))

        visit 'dashboard/items'

        expect(page).to have_link("Edit Item", :href => "/items/#{item_1.id}/edit")

      end
      it 'can see a link to delete unordered items' do
        merchant_1 = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

        item_1 = merchant_1.items.create!(name: "Amaretto Sour", description: "a sweet nutty cocktail that calls for a full bodied spirit to pair with the bright citrus and sugar. di Amore Amaretto is an excellent choice with its rich body and caramel, almond flavors.", image_url: "https://bit.ly/2BoIMFi", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
        item_2 = merchant_1.items.create!(name: "Espresso Martini", description: "a cold, coffee-flavored cocktail made with vodka, espresso coffee, coffee liqueur, and sugar syrup.", image_url: "https://bit.ly/2A4XQYS", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
        order_1 = Order.create!(status: 3)
        order_item_1 = OrderItem.create!(item: item_2, order: order_1, quantity: 16, price: (item_1.price * 16))
        visit 'dashboard/items'


        expect(page).to have_link("Delete Item", :href => "/items/#{item_1.id}")
        expect(page).not_to have_link("Delete Item", :href => "/items/#{item_2.id}")

      end

      it 'can see links to enable and disable items' do
        merchant_1 = create(:user, role: 1)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_1)

        item_1 = merchant_1.items.create!(name: "Amaretto Sour", description: "a sweet nutty cocktail that calls for a full bodied spirit to pair with the bright citrus and sugar. di Amore Amaretto is an excellent choice with its rich body and caramel, almond flavors.", image_url: "https://bit.ly/2BoIMFi", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
        item_2 = merchant_1.items.create!(name: "Espresso Martini", description: "a cold, coffee-flavored cocktail made with vodka, espresso coffee, coffee liqueur, and sugar syrup.", image_url: "https://bit.ly/2A4XQYS", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2), status: false)


        visit 'dashboard/items'

        
        expect(page).to have_link("Disable", :href => "/items/#{item_1.id}/edit")
        expect(page).to have_link("Enable", :href => "/items/#{item_2.id}/edit")

      end
    end
  end
