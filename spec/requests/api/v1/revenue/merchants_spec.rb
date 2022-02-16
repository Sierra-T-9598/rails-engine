require 'rails_helper'

RSpec.describe 'Merchants revenue API' do
  describe 'index' do

    describe 'happy path, get merchants of a given quantity' do
      let!(:merchant_1) { create :merchant }
      let!(:merchant_2) { create :merchant }
      let!(:merchant_3) { create :merchant }
      let!(:merchant_4) { create :merchant }

      let!(:item_1) { create :item, { merchant_id: merchant_1.id } }
      let!(:item_2) { create :item, { merchant_id: merchant_2.id } }
      let!(:item_3) { create :item, { merchant_id: merchant_2.id } }
      let!(:item_4) { create :item, { merchant_id: merchant_3.id } }
      let!(:item_5) { create :item, { merchant_id: merchant_3.id } }
      let!(:item_6) { create :item, { merchant_id: merchant_3.id } }
      let!(:item_7) { create :item, { merchant_id: merchant_4.id } }
      let!(:item_8) { create :item, { merchant_id: merchant_4.id } }
      let!(:item_9) { create :item, { merchant_id: merchant_4.id } }
      let!(:item_10) { create :item, { merchant_id: merchant_4.id } }

      let!(:customer) { create :customer }

      let!(:invoice_1) { create :invoice, { customer_id: customer.id, created_at: DateTime.new(2022, 1, 1) } }
      let!(:invoice_2) { create :invoice, { customer_id: customer.id, created_at: DateTime.new(2022, 2, 1) } }

      let!(:transaction_1) { create :transaction, { invoice_id: invoice_1.id, result: "success" } }
      let!(:transaction_2) { create :transaction, { invoice_id: invoice_2.id, result: "success" } }

      let!(:invoice_item_1) { create :invoice_item, { invoice_id: invoice_1.id, item_id: item_1.id, unit_price: 100, quantity: 100 }}
      let!(:invoice_item_2) { create :invoice_item, { invoice_id: invoice_1.id, item_id: item_2.id, unit_price: 100, quantity: 10 }}
      let!(:invoice_item_3) { create :invoice_item, { invoice_id: invoice_1.id, item_id: item_3.id, unit_price: 100, quantity: 10 }}
      let!(:invoice_item_4) { create :invoice_item, { invoice_id: invoice_1.id, item_id: item_4.id, unit_price: 100, quantity: 9 }}
      let!(:invoice_item_5) { create :invoice_item, { invoice_id: invoice_1.id, item_id: item_5.id, unit_price: 100, quantity: 9 }}
      let!(:invoice_item_6) { create :invoice_item, { invoice_id: invoice_2.id, item_id: item_6.id, unit_price: 100, quantity: 9 }}
      let!(:invoice_item_7) { create :invoice_item, { invoice_id: invoice_2.id, item_id: item_7.id, unit_price: 100, quantity: 100 }}
      let!(:invoice_item_8) { create :invoice_item, { invoice_id: invoice_2.id, item_id: item_8.id, unit_price: 100, quantity: 10 }}
      let!(:invoice_item_9) { create :invoice_item, { invoice_id: invoice_2.id, item_id: item_9.id, unit_price: 100, quantity: 10 }}
      let!(:invoice_item_10) { create :invoice_item, { invoice_id: invoice_2.id, item_id: item_10.id, unit_price: 100, quantity: 1 }}

      xit 'returns a list of merchants be specified quantity and ordered by descending total revenue' do
        # merchant_1 = (create :merchant)
        # merchant_2 = (create :merchant)
        # merchant_3 = (create :merchant)
        # merchant_4 = (create :merchant)
        #
        # item_1 = (create :item, { merchant_id: merchant_1.id })
        # item_2 = (create :item, { merchant_id: merchant_2.id })
        # item_3 = (create :item, { merchant_id: merchant_2.id })
        # item_4 = (create :item, { merchant_id: merchant_3.id })
        # item_5 = (create :item, { merchant_id: merchant_3.id })
        # item_6 = (create :item, { merchant_id: merchant_3.id })
        # item_7 = (create :item, { merchant_id: merchant_4.id })
        # item_8 = (create :item, { merchant_id: merchant_4.id })
        # item_9 = (create :item, { merchant_id: merchant_4.id })
        # item_10 = (create :item, { merchant_id: merchant_4.id })

        # customer = (create :customer)
        #
        # invoice_1 = (create :invoice, { customer_id: customer.id, created_at: DateTime.new(2022, 1, 1) })
        # invoice_2 = (create :invoice, { customer_id: customer.id, created_at: DateTime.new(2022, 2, 1) })
        # transaction_1 = (create :transaction, { invoice_id: invoice_1.id, result: "success" })
        # transaction_2 = (create :transaction, { invoice_id: invoice_2.id, result: "success" })
        #
        # invoice_item_1 = (create :invoice_item, { invoice_id: invoice_1.id, item_id: item_1.id, unit_price: 100, quantity: 100 })
        # invoice_item_2 = (create :invoice_item, { invoice_id: invoice_1.id, item_id: item_2.id, unit_price: 100, quantity: 10 })
        # invoice_item_3 = (create :invoice_item, { invoice_id: invoice_1.id, item_id: item_3.id, unit_price: 100, quantity: 10 })
        # invoice_item_4 = (create :invoice_item, { invoice_id: invoice_1.id, item_id: item_4.id, unit_price: 100, quantity: 9 })
        # invoice_item_5 = (create :invoice_item, { invoice_id: invoice_1.id, item_id: item_5.id, unit_price: 100, quantity: 9 })
        # invoice_item_6 = (create :invoice_item, { invoice_id: invoice_2.id, item_id: item_6.id, unit_price: 100, quantity: 9 })
        # invoice_item_7 = (create :invoice_item, { invoice_id: invoice_2.id, item_id: item_7.id, unit_price: 100, quantity: 100 })
        # invoice_item_8 = (create :invoice_item, { invoice_id: invoice_2.id, item_id: item_8.id, unit_price: 100, quantity: 10 })
        # invoice_item_9 = (create :invoice_item, { invoice_id: invoice_2.id, item_id: item_9.id, unit_price: 100, quantity: 10 })
        # invoice_item_10 = (create :invoice_item, { invoice_id: invoice_2.id, item_id: item_10.id, unit_price: 100, quantity: 1 })
        quantity_params = 3
        get "/api/v1/revenue/merchants?quantity=#{quantity_params}"
        require "pry"; binding.pry
        expect(response.status).to be(200)

        merchants = JSON.parse(response.body, symbolize_names: true)
        top_revenue = merchants[:data].first[:attributes][:revenue]
        last_revenue = merchants[:data].last[:attributes][:revenue]
        expected = (top_revenue > last_revenue)

        expect(expected).to be(true)
      end
    end
  end
end
