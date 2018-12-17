FactoryBot.define do
  factory :user, class: User do
    name {Faker::Name.unique.name}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zipcode {Faker::Address.zip}
    email {"#{name}@gmail.com".downcase}
    password {Faker::Internet.password(5)}
  end
end
