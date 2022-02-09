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

  describe 'show' do
    describe 'happy path' do
      it 'returns the merchant data corresponding with the given id' do
        id = create(:merchant).id

        get api_v1_merchant_path(id)
        merchant = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(200)

        expect(merchant).to have_key(:data)
        expect(merchant[:data][:id]).to eq(id.to_s)

        expect(merchant[:data][:id]).to be_a String
        expect(merchant[:data][:attributes][:name]).to be_a String
      end
    end

    describe 'sad path' do
      it 'returns a 404 status if merchant is not found' do
        get api_v1_merchant_path(1)

        no_merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(404)

        expect(no_merchant).to have_key(:errors)
        expect(no_merchant[:errors][:exception]).to eq("Couldn't find Merchant with 'id'=1")
      end
    end
  end

  describe "merchant's items" do
    describe 'happy path' do
      it "returns all of the specified merchant's items" do
        merchant_1 = create(:merchant)
        items_for_merchant_1 = create_list(:item, 5, merchant: merchant_1)

        merchant_2 = create(:merchant)
        items_for_merchant_2 = create_list(:item, 3, merchant: merchant_2)

        id = merchant_1.id

        get api_v1_merchant_items_path(id)
        items = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(items).to have_key(:data)
        expect(items[:data].count).to eq(5)

        items[:data].each do |item|
          expect(item[:id]).to be_a String
          expect(item).to have_key(:attributes)
          expect(item[:attributes][:name]).to be_a String
          expect(item[:attributes][:description]).to be_a String
          expect(item[:attributes][:unit_price]).to be_a Float
          expect(item[:attributes][:merchant_id]).to be_an Integer
        end
      end

      describe 'sad path' do
        it 'returns a 404 status if no items are listed because no merchant is found' do
          get api_v1_merchant_items_path(1)

          expect(response.status).to eq(404)
          expect(JSON.parse(response.body, symbolize_names: true)).to have_key(:errors)
          expect(JSON.parse(response.body, symbolize_names: true)[:errors][:exception]).to eq("Couldn't find Merchant with 'id'=1")
        end
      end
    end
  end
end
