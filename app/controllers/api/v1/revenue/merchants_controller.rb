class  Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity]
      merchants = Merchant.top_merchants_by_revenue(params[:quantity])
      render json: ::MerchantNameRevenueSerializer.new(merchants).serializable_hash.to_json
    else
      render_invalid_merchant_quantity_params
    end
  end
end
