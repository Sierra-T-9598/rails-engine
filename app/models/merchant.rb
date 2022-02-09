class Merchant < ApplicationRecord
  #relationships
  has_many :items
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  #validations
  validates :name, presence: true
  #class methods
    #case insenstive search
    #order by name alphabetically & pick first result
  def self.find_merchant_by_name(query)
    where('name ILIKE ?', "%#{query}%")
    .order(:name)
    .first
  end
end
