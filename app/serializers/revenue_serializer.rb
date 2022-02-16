class RevenueSerializer
  include JSONAPI::Serializer

  def self.revenue_by_date(revenue)
        { data: {
          id: nil,
          type: 'revenue',
          attributes: {
            revenue: revenue
          }
        } }
  end

  def self.invalid_params
    { error: { exception: 'No params or invalid params given' } }
  end
end
