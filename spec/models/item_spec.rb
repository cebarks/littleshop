require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Validations' do
    it {should belong_to(:user)}
    it {should have_many(:order_items)}
    it {should have_many(:orders).through(:order_items)}
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:inventory_qty)}
    it {should validate_presence_of(:price)}
    it {should validate_presence_of(:user)}
  end
  describe 'Class Methods' do
    before(:each) do
      @user_1 = User.create(name: Faker::Name.name, address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zipcode: Faker::Address.zip, email: "everythingisfine@gmail.com", password: Faker::Internet.password(7), role: 0)
      @item_1 = @user_1.items.create(name: "Amaretto Sour", description: "a sweet nutty cocktail that calls for a full bodied spirit to pair with the bright citrus and sugar. di Amore Amaretto is an excellent choice with its rich body and caramel, almond flavors.", image_url: "https://bit.ly/2BoIMFi", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
      @item_2 = @user_1.items.create(name: "Espresso Martini", description: "a cold, coffee-flavored cocktail made with vodka, espresso coffee, coffee liqueur, and sugar syrup.", image_url: "https://bit.ly/2A4XQYS", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
      @item_3 = @user_1.items.create(name: "Manhattan", description: "a cocktail made with whiskey, sweet vermouth and bitters. While rye is the traditional whiskey of choice, other commonly used whiskeys include Canadian whisky, bourbon, blended whiskey and Tennessee whiskey.", image_url: "https://bit.ly/2S5enTr", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
      @item_4 = @user_1.items.create(name: "Old Fashioned", description: "a cocktail made by muddling sugar with bitters, then adding alcohol, originally whiskey but now sometimes brandy and finally a twist of citrus rind. It is traditionally served in a short, round, tumbler-like glass, which is called an Old Fashioned glass, after the drink.", image_url: "https://bit.ly/2EC04Tc", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
      @item_5 = @user_1.items.create(name: "Dry Martini", description: "made with gin and vermouth, this drink is garnished with an olive or a lemon twist. Over the years, the martini has become one of the best-known mixed alcoholic beverages. H. L. Mencken called the martini 'the only American invention as perfect as the sonnet.'", image_url: "https://bit.ly/2A4b8ER", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
      @item_6 = @user_1.items.create(name: "Daiquiri", description: "a family of cocktails whose main ingredients are rum, citrus juice, and sugar or other sweetener. The daiquiri is one of the six basic drinks listed in David A. Embury's classic The Fine Art of Mixing Drinks, which also lists some variations.", image_url: "https://bit.ly/2EC0kl8", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
      @item_7 = @user_1.items.create(name: "Mai Tai", description: "a cocktail based on rum, Curaçao liqueur, orgeat syrup, and lime juice, associated with Polynesian-style settings.", image_url: "https://bit.ly/2A6Ehzc", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
      @item_8 = @user_1.items.create(name: "Aviation", description: "a classic cocktail made with gin, maraschino liqueur, crème de violette, and lemon juice. Some recipes omit the crème de violette. It is served straight up, in a cocktail glass.", image_url: "https://bit.ly/2CiGfOL", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
      @item_9 = @user_1.items.create(name: "Snowball", description: "a mixture of Advocaat and lemonade in approximately equal parts. It may have other ingredients, to taste. It typically contains a squeeze of fresh lime juice, which is shaken with the advocaat before pouring into a glass and topping up with lemonade.", image_url: "https://bit.ly/2LoVyIu", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))
      @item_10 = @user_1.items.create(name: "Bloody Mary", description: "a cocktail containing vodka, tomato juice, and combinations of other spices and flavorings including Worcestershire sauce, hot sauces, garlic, herbs, horseradish, celery, olives, salt, black pepper, lemon juice, lime juice and/or celery salt.", image_url: "https://bit.ly/2S8MVUP", inventory_qty: rand(1..9999), price: Faker::Number.decimal(2))

      @order_1 = Order.create(status: 1)
      @order_2 = Order.create(status: 1)
      @order_3 = Order.create(status: 2)

      @oi_1 = OrderItem.create(item_id: @item_1.id, order_id: @order_1.id, quantity: 1, price: 1)
      @oi_2 = OrderItem.create(item_id: @item_2.id, order_id: @order_1.id, quantity: 2, price: 2)
      @oi_3 = OrderItem.create(item_id: @item_3.id, order_id: @order_1.id, quantity: 4, price: 4)
      @oi_4 = OrderItem.create(item_id: @item_4.id, order_id: @order_1.id, quantity: 8, price: 44)
      @oi_5 = OrderItem.create(item_id: @item_5.id, order_id: @order_2.id, quantity: 16, price: 440)
      @oi_6 = OrderItem.create(item_id: @item_6.id, order_id: @order_2.id, quantity: 32, price: 4400)
      @oi_7 = OrderItem.create(item_id: @item_7.id, order_id: @order_2.id, quantity: 64, price: 9999)
      @oi_8 = OrderItem.create(item_id: @item_8.id, order_id: @order_2.id, quantity: 128, price: 22222)
      @oi_9 = OrderItem.create(item_id: @item_9.id, order_id: @order_2.id, quantity: 256, price: 40000)
      # an item should not show up in the top/bottom 5 if it was ordered but the order was cancelled
      @oi_10 = OrderItem.create(item_id: @item_10.id, order_id: @order_3.id, quantity: 512, price: 85400)
      @oi_11 = OrderItem.create(item_id: @item_1.id, order_id: @order_3.id, quantity: 2, price: 8)
    end
    it '.top_five_by_popularity' do
      expect(Item.top_five_by_popularity).to eq([@item_9, @item_8, @item_7, @item_6, @item_5])
    end
    it '.bottom_five_by_popularity' do
      expect(Item.bottom_five_by_popularity).to eq([@item_2, @item_1, @item_3, @item_4, @item_5])
    end
  end
end
