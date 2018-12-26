FactoryBot.define do
  factory :order_item, class: OrderItem do
    price {4}
    quantity {1}
    association :order, factory: :order
    association :item, factory: :item
  end
end
