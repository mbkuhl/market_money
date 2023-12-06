FactoryBot.define do
  factory :market do
    name { Faker::Lorem.words(number: 2, exclude_words: 'id, error').join(" ") }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    county { Faker::Games::Pokemon.location}
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    lat { Faker::Address.latitude }
    lon { Faker::Address.longitude }
  end
end