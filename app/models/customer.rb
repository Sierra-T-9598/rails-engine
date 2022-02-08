class Customer < ApplicationRecord
  #relationships
  has_many :invoices
  #validations
  validates_presence_of :first_name
  validates_presence_of :last_name 
end
