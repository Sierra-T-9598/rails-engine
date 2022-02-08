require 'rails_helper'

describe "Merchants API" do
  describe 'index' do
    describe 'happy path' do
      it 'returns a list of merchants' do
        create_list(:merchant, 3)

        get api_v1_merchants_path

        expect(response.status).to eq(200)
        merchants = JSON.parse(response.body, symbolize_names: true)

        expect(merchants).to have_key(:data)
        expect(merchants[:data].count).to eq(3)

        merchants[:data].each do |merchant|
          expect(merchant[:id]).to be_a String
          expect(merchant[:attributes][:name]).to be_a String
        end
      end
    end

    describe 'sad path' do
      it 'returns an empty collection when no merchants exist' do
        get api_v1_merchants_path

        expect(response.status).to eq(200)
        no_merchants = JSON.parse(response.body, symbolize_names: true)
        
        expect(Merchant.count).to eq(0)
        expect(no_merchants[:data]).to eq([])
      end
    end
  end
end
