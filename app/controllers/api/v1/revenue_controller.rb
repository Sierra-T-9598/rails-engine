class Api::V1::RevenueController < ApplicationController
  def index
    if params[:start] && params[:end]
      revenue = Invoice.total_revenue(params[:start], params[:end])
      render json: RevenueSerializer.revenue_by_date(revenue)
    else
      render_invalid_revenue_params
    end
  end
end
