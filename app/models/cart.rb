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

  def increase_item_count(item_id)
    item = Item.find(item_id)
    id = item_id.to_s
    if item.inventory_qty > @contents[id]
      @contents[id] += 1
    end
    @contents
  end

  def decrease_item_count(item_id)
    id = item_id.to_s
    if @contents[id] == 0
      remove_item(id)
    elsif
      @contents[id] -= 1
      if @contents[id] == 0
        remove_item(id)
      end
    end
    @contents
  end

  def create_order(order_user)
    order = Order.create(status: :pending, user: order_user)
    @contents.each do |item_id_string, item_quantity|
      oitem = Item.find(item_id_string.to_i)
      OrderItem.create(order: order, item: oitem, quantity: item_quantity, price: oitem.price)
    end
    order
  end
end
