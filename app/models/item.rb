class Item < ApplicationRecord
  # relationships
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  #validations
  validates_presence_of(:name)
  validates_presence_of(:description)
  validates_presence_of(:unit_price)
  validates :unit_price, numericality: { greater_than: 0.0 }
  validates :merchant_id, numericality: true
  #class methods
  def self.find_all_items_by_name(query)
    where('name ILIKE ?', "%#{query}%")
    .order(:name)
  end

  def self.find_all_items_filter_min(query)
    where("unit_price >= #{query}")
    .order(:name)
  end

  def self.find_all_items_filter_max(query)
    where("unit_price <= #{query}")
    .order(:name)
  end

  def self.find_all_items_between(min, max)
    where("unit_price >= #{min}")
    .where("unit_price <= #{max}")
    .order(:name)
  end
end
