class Cart
  attr_reader :contents

  def initialize(cart)
    @contents = cart || Hash.new(0)
  end

  def add_item(item)
    binding.pry
    item_id_string = item.id.to_s
    @contents[item_id_string] ||= 0
    @contents[item_id_string] += 1
  end

  def amount(item_id)
    item_id_string = item_id.to_s
    @contents[item_id_string] ||= 0
  end

  def total_count
    @contents.values.sum
  end

  def all_items
    binding.pry
    @contents.map do |item_id, quantity|
      Item.find(item_id)
    end
  end

  def grand_total
    items = all_items
    grand_total = 0
    items.each do |item|
      quantity = amount(item.id)
      grand_total += (item.price.to_i * quantity)
    end
    grand_total
  end

  def item_subtotal(item)
    price = item.price
    quantity = amount(item.id)
    price * quantity
  end

end
