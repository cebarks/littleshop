require 'faker'

#users
# Item.destroy_all
# User.destroy_all
# Order.destroy_all

  #default users
  user_1 = User.create!(name: Faker::Name.name, address: Faker::Address.street_address, city: Faker::Address.city, state: "CA", zipcode: Faker::Address.zip.to_i, email: "everythingisfine@gmail.com", password: Faker::Internet.password(7))
  user_2 = User.create!(name: Faker::Name.name, address: Faker::Address.street_address, city: Faker::Address.city, state: "NY", zipcode: Faker::Address.zip.to_i, email: "no_tolerance@gmail.com", password: Faker::Internet.password(7))
  user_3 = User.create!(name: Faker::Name.name, address: Faker::Address.street_address, city: Faker::Address.city, state: "FL", zipcode: Faker::Address.zip.to_i, email: "adult_beverage_enthusiast@gmail.com", password: Faker::Internet.password(7))
  user_4 = User.create!(name: "Regular User", address: Faker::Address.street_address, city: Faker::Address.city, state: "AK", zipcode: Faker::Address.zip.to_i, email: "user@gmail.com", password: "123")

  #merchants
  user_5 = User.create!(name: "Nixon Products", address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zipcode: Faker::Address.zip.to_i, email: "salesman@nixon.com", password: Faker::Internet.password(7), role: 1)
  user_6 = User.create!(name: "Blockbuster Cocktails", address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zipcode: Faker::Address.zip.to_i, email: "merchant@blockbuster.com", password: Faker::Internet.password(7), role: 1)
  user_7 = User.create!(name: "merchant", address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zipcode: Faker::Address.zip.to_i, email: "merchant@gmail.com", password: "123", role: 1)

  #admins
  User.create!(name: "admin", address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zipcode: Faker::Address.zip.to_i, email: "admin@admin.com", password: "123", role: 2)

  #items
  item_1 = user_5.items.create!(name: "Amaretto Sour", description: "a sweet nutty cocktail that calls for a full bodied spirit to pair with the bright citrus and sugar. di Amore Amaretto is an excellent choice with its rich body and caramel, almond flavors.", image_url: "https://bit.ly/2BoIMFi", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_2 = user_5.items.create!(name: "Espresso Martini", description: "a cold, coffee-flavored cocktail made with vodka, espresso coffee, coffee liqueur, and sugar syrup.", image_url: "https://bit.ly/2A4XQYS", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_3 = user_6.items.create!(name: "Manhattan", description: "a cocktail made with whiskey, sweet vermouth and bitters. While rye is the traditional whiskey of choice, other commonly used whiskeys include Canadian whisky, bourbon, blended whiskey and Tennessee whiskey.", image_url: "https://bit.ly/2S5enTr", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_4 = user_7.items.create!(name: "Old Fashioned", description: "a cocktail made by muddling sugar with bitters, then adding alcohol, originally whiskey but now sometimes brandy and finally a twist of citrus rind. It is traditionally served in a short, round, tumbler-like glass, which is called an Old Fashioned glass, after the drink.", image_url: "https://bit.ly/2EC04Tc", inventory_qty: 7, price: Faker::Number.decimal(2))
  item_5 = user_6.items.create!(name: "Dry Martini", description: "made with gin and vermouth, this drink is garnished with an olive or a lemon twist. Over the years, the martini has become one of the best-known mixed alcoholic beverages. H. L. Mencken called the martini 'the only American invention as perfect as the sonnet.'", image_url: "https://bit.ly/2A4b8ER", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_6 = user_6.items.create!(name: "Daiquiri", description: "a family of cocktails whose main ingredients are rum, citrus juice, and sugar or other sweetener. The daiquiri is one of the six basic drinks listed in David A. Embury's classic The Fine Art of Mixing Drinks, which also lists some variations.", image_url: "https://bit.ly/2EC0kl8", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2), status: false)
  item_7 = user_6.items.create!(name: "Mai Tai", description: "a cocktail based on rum, Curaçao liqueur, orgeat syrup, and lime juice, associated with Polynesian-style settings.", image_url: "https://bit.ly/2A6Ehzc", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_8 = user_6.items.create!(name: "Aviation", description: "a classic cocktail made with gin, maraschino liqueur, crème de violette, and lemon juice. Some recipes omit the crème de violette. It is served straight up, in a cocktail glass.", image_url: "https://bit.ly/2Byb5RE", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_9 = user_6.items.create!(name: "Snowball", description: "a mixture of Advocaat and lemonade in approximately equal parts. It may have other ingredients, to taste. It typically contains a squeeze of fresh lime juice, which is shaken with the advocaat before pouring into a glass and topping up with lemonade.", image_url: "https://bit.ly/2LoVyIu", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_10 = user_7.items.create!(name: "Bloody Mary", description: "a cocktail containing vodka, tomato juice, and combinations of other spices and flavorings including Worcestershire sauce, hot sauces, garlic, herbs, horseradish, celery, olives, salt, black pepper, lemon juice, lime juice and/or celery salt.", image_url: "https://bit.ly/2S8MVUP", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_11 = user_7.items.create!(name: "Cantaritos", description: "a juicy (freshly squeezed orange, grapefruit and lime) and refreshing slightly salty tequila invigorated with sparkling grapefruit soda. A cocktail commonly made in bars, cafés and even road side stalls of Jalisco, Mexico.", image_url: "https://bit.ly/2EqZCq5", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_12 = user_7.items.create!(name: "South Side", description: "an electric cocktail made with gin, lime juice, simple syrup and mint.", image_url: "https://bit.ly/2PJI1vq", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_13 = user_7.items.create!(name: "Cosmopolitan", description: "a cocktail made with vodka, triple sec, cranberry juice, and freshly squeezed organic lime juice.", image_url: "https://bit.ly/2A5kwrO", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_14 = user_7.items.create!(name: "Mojito", description: "a traditional Cuban highball. Traditionally, a mojito is a cocktail that consists of five ingredients: white rum, sugar, lime juice, soda water, and mint. Its combination of sweetness, citrus, and mint flavors is intended to complement the rum, which has made the mojito a popular summer drink.", image_url: "https://bit.ly/2QzcCRM", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_15 = user_7.items.create!(name: "Sidecar", description: "a cocktail traditionally made with cognac, orange liqueur, plus lemon juice. In its ingredients, the drink is perhaps most closely related to the older brandy crusta, which differs both in presentation and in proportions of its components.", image_url: "https://bit.ly/2A2RBF4", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_16 = user_7.items.create!(name: "Long Island Iced Tea", description: "typically made with vodka, tequila, light rum, triple sec, gin, and a splash of cola, which gives the drink the same amber hue as its namesake.", image_url: "https://bit.ly/2EpUBOF", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_17 = user_7.items.create!(name: "Whiskey Sour", description: "a mixed drink containing whiskey, lemon juice, sugar, and optionally, a dash of egg white.", image_url: "https://bit.ly/2LsUsLF", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_18 = user_7.items.create!(name: "Moscow Mule", description: "a cocktail made with vodka, spicy ginger beer, and lime juice, garnished with a slice or wedge of lime and mint leaves.", image_url: "https://bit.ly/2rICjQZ", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_19 = user_7.items.create!(name: "Tom Collins", description: "a cocktail made from gin, lemon juice, sugar, and carbonated water. First memorialized in writing in 1876 by Jerry Thomas, the 'father of American mixology', this drink is typically served in a Collins glass over ice. ", image_url: "https://bit.ly/2zZLkty", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
  item_20 = user_7.items.create!(name: "Gimlet", description: "a cocktail typically made of 2 part gin, 1 part lime juice, and soda. A 1928 description of the drink was: 'gin, a spot of lime, and soda'. The description in the 1953 Raymond Chandler novel The Long Goodbye stated that 'a real gimlet is half gin and half Rose's lime juice and nothing else'.", image_url: "https://bit.ly/2S6DFRb", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))

  #orders
  order_1 = Order.create!(status: 0, user: user_1) #pending
  order_2 = Order.create!(status: 1, user: user_1, created_at: 7.days.ago) #complete
  order_3 = Order.create!(status: 2, user: user_2) #cancelled
  order_4 = Order.create!(status: 1, user: user_2, created_at: 2.days.ago) #complete
  order_5 = Order.create!(status: 1, user: user_2, created_at: 1.days.ago) #complete
  order_6 = Order.create!(status: 1, user: user_3, created_at: 40.days.ago) #complete
  order_7 = Order.create!(status: 1, user: user_3, created_at: 12.days.ago) #complete
  order_8 = Order.create!(status: 1, user: user_3, created_at: 413.days.ago) #complete
  order_9 = Order.create!(status: 0, user: user_4, created_at: 2.days.ago) #pending
  order_10 = Order.create!(status: 1, user: user_4, created_at: 6.days.ago) #complete
  order_11 = Order.create!(status: 1, user: user_4, created_at: 453.days.ago) #complete
  order_12 = Order.create!(status: 1, user: user_4, created_at: 5.days.ago) #complete
  order_13 = Order.create!(status: 0, user: user_7, created_at: 15.days.ago) #pending
  order_14 = Order.create!(status: 1, user: user_7, created_at: 35.days.ago) #complete
  order_15 = Order.create!(status: 2, user: user_7, created_at: 50.days.ago) #cancelled

  #order items
  OrderItem.create!(item: item_1, order: order_3, quantity: 2, price: item_1.price)
  OrderItem.create!(item: item_2, order: order_1, quantity: 4, price: (item_2.price * 4))
  OrderItem.create!(item: item_3, order: order_3, quantity: 8, price: (item_3.price * 8))
  OrderItem.create!(item: item_4, order: order_2, quantity: 16, price: (item_4.price * 16))
  OrderItem.create!(item: item_5, order: order_1, quantity: 32, price: (item_5.price * 32))
  OrderItem.create!(item: item_6, order: order_3, quantity: 64, price: (item_6.price * 64))
  OrderItem.create!(item: item_7, order: order_2, quantity: 128, price: (item_7.price * 128))
  OrderItem.create!(item: item_8, order: order_1, quantity: 256, price: (item_8.price * 256))
  OrderItem.create!(item: item_9, order: order_3, quantity: 512, price: (item_9.price * 512))
  OrderItem.create!(item: item_10, order: order_2, quantity: 500, price: (item_10.price * 500))
  OrderItem.create!(item: item_11, order: order_1, quantity: 490, price: (item_11.price * 490))
  OrderItem.create!(item: item_12, order: order_3, quantity: 480, price: (item_12.price * 480))
  OrderItem.create!(item: item_13, order: order_2, quantity: 320, price: (item_13.price * 320))
  OrderItem.create!(item: item_14, order: order_1, quantity: 150, price: (item_14.price * 150))
  OrderItem.create!(item: item_15, order: order_3, quantity: 645, price: (item_15.price * 645))
  OrderItem.create!(item: item_16, order: order_2, quantity: 2, price: (item_16.price * 2))
  OrderItem.create!(item: item_17, order: order_1, quantity: 33, price: (item_17.price * 33))
  OrderItem.create!(item: item_18, order: order_3, quantity: 16, price: (item_18.price * 16))
  OrderItem.create!(item: item_19, order: order_2, quantity: 41, price: (item_19.price * 41))
  OrderItem.create!(item: item_20, order: order_1, quantity: 29, price: (item_20.price * 29))
  OrderItem.create!(item: item_1, order: order_2, quantity: 300, price: (item_1.price * 300))
  OrderItem.create!(item: item_1, order: order_4, quantity: 100, price: (item_1.price * 100))


  OrderItem.create!(item: item_5, order: order_5, quantity: 100, price: (item_5.price * 100))
  OrderItem.create!(item: item_4, order: order_5, quantity: 100, price: (item_4.price * 100))
  OrderItem.create!(item: item_6, order: order_5, quantity: 100, price: (item_6.price * 100))
  OrderItem.create!(item: item_17, order: order_6, quantity: 100, price: (item_17.price * 100))
  OrderItem.create!(item: item_18, order: order_6, quantity: 100, price: (item_18.price * 100))
  OrderItem.create!(item: item_11, order: order_6, quantity: 100, price: (item_11.price * 100))


  OrderItem.create!(item: item_4, order: order_9, quantity: 10, price: (item_17.price * 10))
  OrderItem.create!(item: item_6, order: order_10, quantity: 1, price: (item_18.price))
  OrderItem.create!(item: item_1, order: order_11, quantity: 8, price: (item_11.price * 8))
  OrderItem.create!(item: item_3, order: order_12, quantity: 16, price: (item_11.price * 16))

  #for the merchant that we can log in with:
  OrderItem.create!(item: item_16, order: order_13, quantity: 8, price: (item_16.price * 8))
  OrderItem.create!(item: item_17, order: order_14, quantity: 16, price: (item_17.price * 16))
  OrderItem.create!(item: item_18, order: order_15, quantity: 900, price: (item_18.price * 900))
