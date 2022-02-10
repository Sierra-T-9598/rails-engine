require 'rails_helper'

RSpec.describe 'Items Search API' do
  describe 'find ALL items by search' do
    describe 'happy path' do
      describe 'search by name' do
        it 'returns json object array of all items that match the search' do
          item_1 = create(:item, name: 'Thing 1')
          item_2 = create(:item, name: 'Thing 2')
          item_3 = create(:item, name: 'Thing 3')
          query = "Thing"
          get "/api/v1/items/find_all?name=#{query}"

          items = JSON.parse(response.body, symbolize_names: true)
          expect(response.status).to eq(200)
          expect(items).to have_key(:data)
          expect(items[:data].count).to eq(3)
          expect(items[:data]).to be_an Array
          expect(items[:data].first[:attributes][:name]).to eq(item_1.name)

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

      describe 'search by price' do
        describe 'max price' do
          it 'returns json object array of all items less than or equal to the search' do
            item_1 = create(:item, name: 'Thing 1', unit_price: 3000.0)
            item_2 = create(:item, name: 'Thing 2', unit_price: 4000.0)
            item_3 = create(:item, name: 'Thing 3', unit_price: 5000.0)
            query = 4500.0
            get "/api/v1/items/find_all?max_price=#{query}"

            items = JSON.parse(response.body, symbolize_names: true)
            expect(response.status).to eq(200)
            expect(items).to have_key(:data)
            expect(items[:data].count).to eq(2)
            expect(items[:data]).to be_an Array
            expect(items[:data].first[:attributes][:name]).to eq(item_1.name)

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

        describe 'min price' do
          it 'returns json object array of all items that are greater than or equal to search' do
            item_1 = create(:item, name: 'Thing 1', unit_price: 3000.0)
            item_2 = create(:item, name: 'Thing 2', unit_price: 4000.0)
            item_3 = create(:item, name: 'Thing 3', unit_price: 5000.0)
            item_4 = create(:item, name: 'Thing 4', unit_price: 4500.0)
            query = 4500.0
            get "/api/v1/items/find_all?min_price=#{query}"

            items = JSON.parse(response.body, symbolize_names: true)
            expect(response.status).to eq(200)
            expect(items).to have_key(:data)
            expect(items[:data].count).to eq(2)
            expect(items[:data]).to be_an Array
            expect(items[:data].first[:attributes][:name]).to eq(item_3.name)

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

        describe 'between min and max price' do
          it 'returns json object array of all items that are between or equal to search' do
            item_1 = create(:item, name: 'Thing 1', unit_price: 3000.0)
            item_2 = create(:item, name: 'Thing 2', unit_price: 4000.0)
            item_3 = create(:item, name: 'Thing 3', unit_price: 5000.0)
            item_4 = create(:item, name: 'Thing 4', unit_price: 4500.0)
            min_query = 4300.0
            max_query = 5000.0

            get "/api/v1/items/find_all?min_price=#{min_query}&max_price=#{max_query}"

            items = JSON.parse(response.body, symbolize_names: true)
            expect(response.status).to eq(200)
            expect(items).to have_key(:data)
            expect(items[:data].count).to eq(2)
            expect(items[:data]).to be_an Array
            expect(items[:data].first[:attributes][:name]).to eq(item_3.name)

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
      end
    end

    describe 'sad path' do
      it 'returns a json response of an empty array if no matches are found' do
        item_1 = create(:item, name: 'Thing 1', unit_price: 3000.0)
        item_2 = create(:item, name: 'Thing 2', unit_price: 4000.0)
        item_3 = create(:item, name: 'Thing 3', unit_price: 5000.0)
        item_4 = create(:item, name: 'Thing 4', unit_price: 4500.0)
        query = "Other"

        get "/api/v1/items/find_all?name=#{query}"

        items = JSON.parse(response.body, symbolize_names: true)
        expect(response.status).to eq(200)
        expect(items).to have_key(:data)
        expect(items[:data].count).to eq(0)
        expect(items[:data]).to be_an Array
        expect(items[:data]).to eq([])
      end
    end
  end
end
