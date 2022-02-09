class Transaction < ApplicationRecord
  #relationships
  belongs_to :invoice
  #validations
  validates_presence_of :credit_card_expiration_date
  validates_presence_of :credit_card_number
  validates_presence_of :result
end
