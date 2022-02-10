require 'rails_helper'

RSpec.describe 'Merchant Search API' do
  describe 'find one merchant by search' do
    describe 'happy path' do
      it 'returns the first merchant matching the search result, by alphabetical order' do
        merchant_1 = Merchant.create!(name: "Greatest Coffee Fanatics")
        merchant_2 = Merchant.create!(name: "Coffee Fanatics")
        get '/api/v1/merchants/find?name=coffee'

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(merchant).to have_key(:data)
        expect(merchant[:data][:attributes][:name]).to eq(merchant_2[:name])
      end
    end

    describe 'sad path and edge cases' do
      it 'returns an empty object if there is no match for the search params' do
        merchant_1 = Merchant.create!(name: "Greatest Coffee Fanatics")
        merchant_2 = Merchant.create!(name: "Coffee Fanatics")
        get '/api/v1/merchants/find?name=tea'

        no_merchant = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(200)
        expect(no_merchant).to have_key(:data)
        expect(no_merchant[:data]).to eq({})
      end

      it 'returns a 400 error if no name params are provided' do
        merchant_1 = Merchant.create!(name: "Greatest Coffee Fanatics")
        merchant_2 = Merchant.create!(name: "Coffee Fanatics")
        get '/api/v1/merchants/find'

        expect(response.status).to eq(400)
      end

      it 'returns a 400 error if fragment is left empy for the name params' do
        merchant_1 = Merchant.create!(name: "Greatest Coffee Fanatics")
        merchant_2 = Merchant.create!(name: "Coffee Fanatics")
        get '/api/v1/merchants/find?name='

        expect(response.status).to eq(400)
      end
    end
  end
end
