class Api::V1::MerchantsSearchController < ApplicationController
  def show
    merchant = Merchant.find_merchant_by_name(params[:name])
    if !params[:name]
      render_invalid_merchant_params
    elsif params[:name] == ""
      render_invalid_merchant_params
    elsif merchant != nil
      render json: MerchantSerializer.new(merchant)
    elsif
      render json: MerchantSerializer.no_result
    end
  end
end
