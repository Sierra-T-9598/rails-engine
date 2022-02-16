FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { Faker::Number.number(digits: 16).to_s }
    result { ['success', 'failed'].sample }
  end
end
