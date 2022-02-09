class InvoiceItem < ApplicationRecord
  #relationships
  belongs_to :invoice
  belongs_to :item
  #validations
  validates_presence_of :unit_price
  validates_presence_of :quantity
end
