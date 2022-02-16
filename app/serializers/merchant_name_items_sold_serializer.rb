class MerchantNameItemsSoldSerializer
  include JSONAPI::Serializer

  attributes :name

  attribute :count do |merchant|
    merchant.item_count
  end

  def self.invalid_params
      { error: { exception: 'No params or invalid params given' } }
  end
end
