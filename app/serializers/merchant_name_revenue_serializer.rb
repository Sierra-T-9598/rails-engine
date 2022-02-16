class MerchantNameRevenueSerializer
  include JSONAPI::Serializer

  attributes :name

  attribute :revenue do |merchant|
    merchant.total_revenue
  end

  def self.invalid_params
      { error: { exception: 'No params or invalid params given' } }
  end
end
