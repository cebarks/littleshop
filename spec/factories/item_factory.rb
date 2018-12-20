FactoryBot.define do
  factory :item, class: Item do
    sequence :name do |n|
      "item_#{n}"
    end
    description {Faker::Coffee.notes}
    inventory_qty { 9 }
    price { 10 }

    association :user, factory: :merchant

    trait :disabled do
      status { false }
    end
  end
end
