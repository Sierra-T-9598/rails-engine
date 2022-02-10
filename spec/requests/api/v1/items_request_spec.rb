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

        expect(no_item).to have_key(:error)
        expect(no_item[:error][:exception]).to eq("Couldn't find Item with 'id'=1")
      end
    end
  end

  describe 'create' do
    describe 'happy path' do
      it 'returns the newly created item as a json object' do
        merchant_id = create(:merchant).id
        item_params = ({
                  name: 'Pen',
                  description: 'Writes cool things',
                  unit_price: 500.0,
                  merchant_id: merchant_id,
                })
        headers = {"CONTENT_TYPE" => "application/json"}
        post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)
        created_item = Item.last

        expect(response.status).to eq(201)
        expect(created_item.name).to eq(item_params[:name])
        expect(created_item.description).to eq(item_params[:description])
        expect(created_item.unit_price).to eq(item_params[:unit_price])
        expect(created_item.merchant_id).to eq(item_params[:merchant_id])
      end
    end

    describe 'sad path' do
      it 'does not create the new object if any attributes are missing and returns an error' do
        merchant_id = create(:merchant).id
        item_params = ({
                  name: 'Pen',
                  description: 'Writes cool things',
                  merchant_id: merchant_id,
                })
        headers = {"CONTENT_TYPE" => "application/json"}
        post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

        expect(response.status).to eq(400)
      end

      it 'ignores attributes that are not permitted' do
        merchant_id = create(:merchant).id
        item_params = ({
                  name: 'Pen',
                  description: 'Writes cool things',
                  unit_price: 500.0,
                  merchant_id: merchant_id,
                  non_permitted_attribute: 'dkjsfhskrjgbskj!!!'
                })
        headers = {"CONTENT_TYPE" => "application/json"}
        post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)
        item = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(201)
        expect(item[:data][:attributes]).to_not have_key(:non_permitted_attribute)
      end
    end
  end

  describe 'update' do
    describe 'happy path' do
      it 'can update an existing item object when given id' do
        id = create(:item).id
        previous_name = Item.last.name
        item_params = { name: "New Name" }
        headers = {"CONTENT_TYPE" => "application/json"}

        patch api_v1_item_path(id), headers: headers, params: JSON.generate({item: item_params})
        item = Item.find_by(id: id)

        expect(response.status).to eq(200)
        expect(item.name).to_not eq(previous_name)
        expect(item.name).to eq("New Name")
        expect(item.description).to eq(Item.last.description)
        expect(item.unit_price).to eq(Item.last.unit_price)
        expect(item.merchant_id).to eq(Item.last.merchant_id)

        json_item = JSON.parse(response.body, symbolize_names: true)

        expect(json_item[:data][:attributes][:name]).to be_a String
        expect(json_item[:data][:attributes][:description]).to be_a String
        expect(json_item[:data][:attributes][:unit_price]).to be_a Float
        expect(json_item[:data][:attributes][:merchant_id]).to be_an Integer
      end
    end
  end

    describe 'sad path' do
      it 'returns the same item if no updates are provided' do
        id = create(:item).id
        previous_name = Item.last.name
        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch api_v1_item_path(id), headers: headers, params: JSON.generate({item: { name: Item.last.name }})
        item = Item.find_by(id: id)

        expect(response.status).to eq(200)
        expect(item.name).to eq(previous_name)
      end

      it 'ignores attributes that are not permitted' do
        id = create(:item).id
        previous_name = Item.last.name
        item_params = ({
                  name: 'Pen',
                  description: 'Writes cool things',
                  unit_price: 500.0,
                  non_permitted_attribute: 'dkjsfhskrjgbskj!!!'
                })
        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch api_v1_item_path(id), headers: headers, params: JSON.generate({item: item_params })
        item = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(item[:data][:attributes]).to_not have_key(:non_permitted_attribute)
        expect(item[:data][:attributes]).to have_key(:merchant_id)
      end

      it 'errors if item cannot be found by id to udpate' do
        item_params = ({
                  name: 'Pen',
                  description: 'Writes cool things',
                  unit_price: 500.0,
                  merchant_id: 1,
                })
        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch api_v1_item_path(1), headers: headers, params: JSON.generate({item: item_params })

        expect(response.status).to eq(404)
      end

      it 'errors if the merchant id associated with the item to update is invalid' do
        id = create(:item).id
        item_params = ({
                  name: 'Pen',
                  description: 'Writes cool things',
                  unit_price: 500.0,
                  merchant_id: "10",
                })
        headers = { 'CONTENT_TYPE' => 'application/json' }
        patch api_v1_item_path(id), headers: headers, params: JSON.generate({item: item_params })

        expect(response.status).to eq(400)
      end
    end
  end

  describe 'destroy' do
    describe 'happy path' do
      it 'deletes the object specified by id' do
        item_id = create(:item).id

        expect{ delete api_v1_item_path(item_id) }.to change(Item, :count).by(-1)
        expect(response.status).to eq(204)
        expect(response.body).to eq('')
    end

    describe 'sad path' do
      it 'cannot find the record to delete and returns an error' do
        delete api_v1_item_path(1)
        expect(response.status).to eq(404)
      end
    end
  end

  describe 'get merchant' do
    describe 'happy path' do
      it "returns the merchant of the specified item as a json object" do
        id = create(:item).id

        get api_v1_item_merchant_index_path(id)
        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(200)
        expect(merchant).to have_key(:data)
        expect(merchant[:data]).to have_key(:attributes)
        expect(merchant[:data][:attributes][:name]).to be_a String
      end
    end

    describe 'sad path' do
      it 'returns a 404 status error if the item is not found' do
        get api_v1_item_merchant_index_path(1)
        result = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq(404)
        expect(result).to have_key(:error)
        expect(result[:error][:exception]).to eq("Couldn't find Item with 'id'=1")
      end
    end
  end
end
