class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def most_items
    if params[:quantity]
      merchants = Merchant.top_merchants_by_items_sold(params[:quantity])
      render json: MerchantNameItemsSoldSerializer.new(merchants)
    else
      render_invalid_merchant_params
    end
  end
end
