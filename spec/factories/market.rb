FactoryBot.define do
  factory :market do
    name { Faker::Book.title }
    street { Faker::Book.author }
    city { Faker::Book.genre }
    county { Faker::Lorem.paragraph }
    state { Faker::Number.within(range: 1..1000) }
    zip { Faker::Number.within(range: 1..1000) }
    state { Faker::Number.within(range: 1..1000) }
    lat { Faker::Number.within(range: 1..1000) }
    lon { Faker::Number.within(range: 1..1000) }
  end
end