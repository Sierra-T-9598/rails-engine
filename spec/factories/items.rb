FactoryBot.define do
  factory :item do
    name { Faker::Coffee.blend_name }
    unit_price { Faker::Number.number(digits: 4) }
    description { Faker::Lorem.sentence }

    association :merchant
  end
end
