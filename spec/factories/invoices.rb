FactoryBot.define do
  factory :invoice do
    association :customer
    association :merchant
    status { ['cancelled', 'completed', 'in progress'].sample }
  end
end 
