FactoryBot.define do
  factory :user, class: User do
    sequence :name do |n|
      "user_#{n}"
    end
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zipcode {Faker::Address.zip.to_i}
    email {"#{name}@gmail.com".downcase}
    password {Faker::Internet.password(5)}

    trait :disabled do
      status { false }
    end

    factory :merchant do
      role {1}
    end

    factory :admin do
      role {2}
    end
  end
end
