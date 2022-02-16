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

  def self.top_merchants_by_revenue(quantity)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .select('SUM(invoice_items.unit_price * invoice_items.quantity) AS total_revenue, merchants.*')
    .group(:id)
    .order(total_revenue: :desc)
    .limit(quantity)
    .distinct
  end

  def self.top_merchants_by_items_sold(quantity = 5)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'}, invoices: {status: 'shipped'})
    .select('SUM(invoice_items.quantity) AS item_count, merchants.*')
    .group(:id)
    .order(item_count: :desc)
    .limit(quantity)
  end
end
