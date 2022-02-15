FactoryBot.define do
  factory :transaction do
    association :invoice
    credit_card_number { Faker::Number(digits: 16).to_s }
    result { [0, 1].sample }
  end 
end
