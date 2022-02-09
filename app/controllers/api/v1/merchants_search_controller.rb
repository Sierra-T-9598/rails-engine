class Api::V1::MerchantsSearchController < ApplicationController
  def show
    merchant = Merchant.find_merchant_by_name(params[:name])
    if merchant != nil
      render json: MerchantSerializer.new(merchant)
    else
      render json: MerchantSerializer.no_result
    end
  end
end
