FactoryBot.define do
  factory :item, class: Item do
    name {Faker::Coffee.unique.blend_name}
    description {Faker::Coffee.notes}
    inventory_qty { rand(1..50) }
    price { rand(1..100) }
    association :user, factory: :merchant

    trait :disabled do
      status { false }
    end
  end
end
