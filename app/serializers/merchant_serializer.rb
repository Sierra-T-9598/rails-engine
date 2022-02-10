class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name

  def self.no_result
    {data: {} }
  end

  def self.invalid_params
    { error: { exception: 'No params or invalid params given' } }
  end
end
