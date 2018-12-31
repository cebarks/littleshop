FactoryBot.define do
  factory :item, class: Item do
    sequence :name do |n|
      "item_#{n}"
    end
    
    description {Faker::Coffee.notes}
    inventory_qty { 9 }
    price { 10 }
    image_url { "https://visualpharm.com/assets/783/Facebook%20Like-595b40b65ba036ed117d1f0f.svg" }

    association :user, factory: :merchant

    trait :disabled do
      status { false }
    end
  end
end
