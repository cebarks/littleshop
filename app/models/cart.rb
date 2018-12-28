class Cart
  attr_reader :contents

  def initialize(cart)
    @contents = cart || Hash.new(0)
  end

  def add_item(item)
    item_id_string = item.id.to_s
    @contents[item_id_string] ||= 0
    @contents[item_id_string] += 1
  end

  def item_amount(item)
    item_id_string = item.id.to_s
    total = @contents[item_id_string]
    total
  end

  def total_count
    @contents.values.sum
  end

  def all_items
    @contents.map do |item_id, quantity|
      Item.find(item_id)
    end
  end

  def grand_total
    items = all_items
    grand_total = 0
    items.each do |item|
      quantity = item_amount(item)
      grand_total += (item.price.to_i * quantity)
    end
    grand_total
  end

  def item_subtotal(item)
    price = item.price
    quantity = item_amount(item)
    price * quantity
  end

  def empty
    @contents = {}
  end

  def remove_item(item_id)
    @contents.delete_if do |item, qty|
      item == item_id.to_s
    end
  end


end
