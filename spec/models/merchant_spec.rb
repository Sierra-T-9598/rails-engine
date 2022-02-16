require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    describe '::find_merchant_by_name' do
      it 'returns the first merchant that matches the query alphabetically' do
        merchant_1 = Merchant.create!(name: 'Burger Bobs')
        merchant_2 = Merchant.create!(name: "Alfie's Burger Shack")
        query = 'Burger'

        expect(Merchant.find_merchant_by_name(query)).to eq(merchant_2)
      end
    end

    # describe '::top_merchants_by_revenue(quantity)' do
    #   it 'returns the specified number of merchants ordered by total revenue' do
    #   end
    # end
  end
end
