require 'rails_helper'

describe 'when any kind of user visits /items' do
  it 'should see all items except disabled ones' do
    merchant_1 = create(:user, role: 1)
    merchant_2 = create(:user, role: 1)
    item_1 = create(:item, user: merchant_1)
    item_2 = merchant_1.items.create(name: "item 2", description: "glitter 2", image_url: "https://bit.ly/2rGOSMR", inventory_qty: 9, price: "6", status: true)
    item_3 = merchant_2.items.create(name: "item 3", description: "glitter 3", image_url: "https://bit.ly/2rGOSMR", inventory_qty: 11, price: "7", status: true)
    item_4 = merchant_2.items.create(name: "item 4", description: "glitter 4", image_url: "https://bit.ly/2rGOSMR", inventory_qty: 12, price: "9", status: false)

    visit items_path

    expect(page).to_not have_content(item_4.name)

    within "#item-#{item_1.id}" do
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content("Quantity: #{item_1.inventory_qty}")
      expect(page).to have_content("Price: $#{item_1.price}")
      expect(page).to_not have_content(merchant_2.name)
    end

    within "#item-#{item_2.id}" do
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(merchant_1.name)
      expect(page).to have_content("Quantity: #{item_2.inventory_qty}")
      expect(page).to have_content("Price: $#{item_2.price}")
      expect(page).to_not have_content(merchant_2.name)
    end

    within "#item-#{item_3.id}" do
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(merchant_2.name)
      expect(page).to have_content("Quantity: #{item_3.inventory_qty}")
      expect(page).to have_content("Price: $#{item_3.price}")
      expect(page).to_not have_content(merchant_1.name)
    end
  end
  it 'should be able to click on the items name to see item show page' do
    merchant_1 = create(:user, role: 1)
    item_1 = merchant_1.items.create(name: "item 1", description: "glitter 1", image_url: "https://bit.ly/2rGOSMR", inventory_qty: 7, price: "5", status: true)

    visit items_path

    click_link("#{item_1.name}")

    expect(current_path).to eq(item_path(item_1))
  end
  it 'should be able to click on the items image to see item show page' do
    merchant_1 = create(:user, role: 1)
    item_1 = merchant_1.items.create(name: "item 1", description: "glitter 1", image_url: "https://bit.ly/2rGOSMR", inventory_qty: 7, price: "5", status: true)

    visit items_path

    page.find("a#drink-pic").click

    expect(current_path).to eq(item_path(item_1))
  end
  it 'shows statistics' do
    user_1 = User.create(name: Faker::Name.name, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zipcode: Faker::Address.zip, email: "everythingisfine@gmail.com", password: Faker::Internet.password(7), role: 0)
    item_1 = user_1.items.create(name: "Amaretto Sour", description: "a sweet nutty cocktail that calls for a full bodied spirit to pair with the bright citrus and sugar. di Amore Amaretto is an excellent choice with its rich body and caramel, almond flavors.", image_url: "https://bit.ly/2BoIMFi", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
    item_2 = user_1.items.create(name: "Espresso Martini", description: "a cold, coffee-flavored cocktail made with vodka, espresso coffee, coffee liqueur, and sugar syrup.", image_url: "https://bit.ly/2A4XQYS", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
    item_3 = user_1.items.create(name: "Manhattan", description: "a cocktail made with whiskey, sweet vermouth and bitters. While rye is the traditional whiskey of choice, other commonly used whiskeys include Canadian whisky, bourbon, blended whiskey and Tennessee whiskey.", image_url: "https://bit.ly/2S5enTr", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
    item_4 = user_1.items.create(name: "Old Fashioned", description: "a cocktail made by muddling sugar with bitters, then adding alcohol, originally whiskey but now sometimes brandy and finally a twist of citrus rind. It is traditionally served in a short, round, tumbler-like glass, which is called an Old Fashioned glass, after the drink.", image_url: "https://bit.ly/2EC04Tc", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
    item_5 = user_1.items.create(name: "Dry Martini", description: "made with gin and vermouth, this drink is garnished with an olive or a lemon twist. Over the years, the martini has become one of the best-known mixed alcoholic beverages. H. L. Mencken called the martini 'the only American invention as perfect as the sonnet.'", image_url: "https://bit.ly/2A4b8ER", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
    item_6 = user_1.items.create(name: "Daiquiri", description: "a family of cocktails whose main ingredients are rum, citrus juice, and sugar or other sweetener. The daiquiri is one of the six basic drinks listed in David A. Embury's classic The Fine Art of Mixing Drinks, which also lists some variations.", image_url: "https://bit.ly/2EC0kl8", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
    item_7 = user_1.items.create(name: "Mai Tai", description: "a cocktail based on rum, Curaçao liqueur, orgeat syrup, and lime juice, associated with Polynesian-style settings.", image_url: "https://bit.ly/2A6Ehzc", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
    item_8 = user_1.items.create(name: "Aviation", description: "a classic cocktail made with gin, maraschino liqueur, crème de violette, and lemon juice. Some recipes omit the crème de violette. It is served straight up, in a cocktail glass.", image_url: "https://bit.ly/2CiGfOL", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
    item_9 = user_1.items.create(name: "Snowball", description: "a mixture of Advocaat and lemonade in approximately equal parts. It may have other ingredients, to taste. It typically contains a squeeze of fresh lime juice, which is shaken with the advocaat before pouring into a glass and topping up with lemonade.", image_url: "https://bit.ly/2LoVyIu", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
    item_10 = user_1.items.create(name: "Bloody Mary", description: "a cocktail containing vodka, tomato juice, and combinations of other spices and flavorings including Worcestershire sauce, hot sauces, garlic, herbs, horseradish, celery, olives, salt, black pepper, lemon juice, lime juice and/or celery salt.", image_url: "https://bit.ly/2S8MVUP", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))

    order_1 = Order.create(status: 1)
    order_2 = Order.create(status: 1)

    OrderItem.create(item: item_1, order: order_1, quantity: 1, price: 1)
    OrderItem.create(item: item_2, order: order_1, quantity: 2, price: 2)
    OrderItem.create(item: item_3, order: order_1, quantity: 4, price: 4)
    OrderItem.create(item: item_4, order: order_1, quantity: 8, price: 44)
    OrderItem.create(item: item_5, order: order_1, quantity: 16, price: 440)
    OrderItem.create(item: item_6, order: order_2, quantity: 32, price: 4400)
    OrderItem.create(item: item_7, order: order_2, quantity: 64, price: 9999)
    OrderItem.create(item: item_8, order: order_2, quantity: 128, price: 22222)
    OrderItem.create(item: item_9, order: order_2, quantity: 256, price: 40000)
    OrderItem.create(item: item_10, order: order_2, quantity: 512, price: 85400)

    visit items_path
    expect(page).to have_content("5 Most Popular Items:\n#{item_10.name} - #{Item.amount_sold(item_10.id)} sold!\n#{item_9.name} - #{Item.amount_sold(item_9.id)} sold!\n#{item_8.name} - #{Item.amount_sold(item_8.id)} sold!\n#{item_7.name} - #{Item.amount_sold(item_7.id)} sold!\n#{item_6.name} - #{Item.amount_sold(item_6.id)} sold!")
    expect(page).to have_content("5 Least Popular Items:\n#{item_1.name} - #{Item.amount_sold(item_1.id)} sold\n#{item_2.name} - #{Item.amount_sold(item_2.id)} sold\n#{item_3.name} - #{Item.amount_sold(item_3.id)} sold\n#{item_4.name} - #{Item.amount_sold(item_4.id)} sold\n#{item_5.name} - #{Item.amount_sold(item_5.id)} sold")
  end
end
