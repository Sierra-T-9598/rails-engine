class Invoice < ApplicationRecord
  #relationships
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  #validations
  validates_presence_of :status

  def self.total_revenue(start_date, end_date)
    joins(:transactions, :invoice_items)
    .where(invoices: {status: 'shipped'}, transactions: {result: 'success'})
    .where(invoices: {created_at: start_date..end_date})
    .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
  end
end
