class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id

  def self.invalid_params
    { error: { exception: 'No params or invalid params given' } }
  end
end
