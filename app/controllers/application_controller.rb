class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_404
  rescue_from ActiveRecord::RecordInvalid, with: :error_400

  def error_404(error)
    render json: { error: { exception: error.to_s} }, status: 404
  end

  def error_400(error)
    render json: { error: {execption: error.to_s} }, status: 400
  end
end
