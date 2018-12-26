class Cart
  attr_reader :contents

  def initialize(cart)
    @contents = cart || Hash.new(0)
  end

  def add_item(item_id)
    item_id_string = item_id.id.to_s
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
    @contents
  end

  def subtotal
    items = Item.all
    subtotal = 0
    items.each do |item|
      quantity = amount(item.id)
      subtotal += (item.price.to_i * quantity)
    end
    subtotal
  end
end
