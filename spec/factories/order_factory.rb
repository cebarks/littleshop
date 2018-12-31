FactoryBot.define do
  factory :order, class: Order do
    status { "complete" }
    association :user, factory: :user

    transient do
      items_count { 2 }
    end

    trait :pending do
      status { "pending" }
    end

    after(:create) do |order, evaluator|
      create_list(:order_item, evaluator.items_count, order: order)
    end
  end
end
