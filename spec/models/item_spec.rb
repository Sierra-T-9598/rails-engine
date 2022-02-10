require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price).is_greater_than(0.0) }
    it { should validate_numericality_of(:merchant_id) }
  end

  describe 'class methods' do
    describe '::find_all_items_by_name(query)' do
      it 'returns array of all items that match the query' do
        item_1 = create(:item, name: 'Pen')
        item_2 = create(:item, name: 'Watch')
        item_3 = create(:item, name: 'Pencil')
        query = 'Pen'

        expect(Item.find_all_items_by_name(query)).to eq([item_1, item_3])
      end
    end

    describe '::find_all_items_filter_min(query)' do
      it 'returns array of all items that are greater than or equal to query' do
        item_1 = create(:item, name: 'Pen', unit_price: 1200)
        item_2 = create(:item, name: 'Watch', unit_price: 2400)
        item_3 = create(:item, name: 'Pencil', unit_price: 1300)
        query = '1300.0'

        expect(Item.find_all_items_filter_min(query)).to eq([item_3, item_2])
      end
    end

    describe '::find_all_items_filter_max(query)' do
      it 'returns array of all items that are less than or equal to query' do
        item_1 = create(:item, name: 'Pen', unit_price: 1200)
        item_2 = create(:item, name: 'Watch', unit_price: 2400)
        item_3 = create(:item, name: 'Pencil', unit_price: 1300)
        query = '1300.0'

        expect(Item.find_all_items_filter_max(query)).to eq([item_1, item_3])
      end
    end

    describe '::find_all_items_between(min_query, max_query)' do
      it 'returns array of all items that are between or equal to the min and max queries' do
        item_1 = create(:item, name: 'Pen', unit_price: 1200)
        item_2 = create(:item, name: 'Watch', unit_price: 2400)
        item_3 = create(:item, name: 'Pencil', unit_price: 1300)
        min_query = '2000.0'
        max_query = '2500.0'

        expect(Item.find_all_items_between(min_query, max_query)).to eq([item_2])
      end
    end
  end
end
