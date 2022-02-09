require 'rails_helper'

RSpec.describe "Items API" do
  describe 'index' do
    describe 'happy path' do
      it 'returns all items as a json object' do
        create_list(:item, 3)
        get api_v1_items_path

        expect(response.status).to eq(200)
        items = JSON.parse(response.body, symbolize_names: true)

        expect(items).to have_key(:data)
        expect(items[:data].count).to eq(3)

        items[:data].each do |item|
          expect(item[:id]).to be_a String
          expect(item).to have_key(:attributes)
          expect(item[:attributes][:name]).to be_a String
          expect(item[:attributes][:description]).to be_a String
          expect(item[:attributes][:unit_price]).to be_a Float
          expect(item[:attributes][:merchant_id]).to be_an Integer
        end
      end
    end

    describe 'sad path' do
      it 'returns an empty collection when no items exist' do
        get api_v1_items_path

        expect(response.status).to eq(200)
        no_items = JSON.parse(response.body, symbolize_names: true)

        expect(Item.count).to eq(0)
        expect(no_items[:data]).to eq([])
      end
    end
  end

  describe 'show' do
    describe 'happy path' do
      it "returns the 'id' specified item as a json object" do
        id = create(:item).id
        get api_v1_item_path(id)

        expect(response.status).to eq(200)
        item = JSON.parse(response.body, symbolize_names: true)

        expect(item).to have_key(:data)
        expect(item[:data][:id]).to eq(id.to_s)

        expect(item[:data][:id]).to be_a String
        expect(item[:data][:attributes][:name]).to be_a String
        expect(item[:data][:attributes][:description]).to be_a String
        expect(item[:data][:attributes][:unit_price]).to be_a Float
        expect(item[:data][:attributes][:merchant_id]).to be_an Integer
      end
    end

    describe 'sad path' do
      it 'returns a 404 status if item is not found' do
        get api_v1_item_path(1)

        no_item = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(404)

        expect(no_item).to have_key(:errors)
        expect(no_item[:errors][:exception]).to eq("Couldn't find Item with 'id'=1")
      end
    end
  end
end
