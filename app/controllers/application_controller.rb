class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :error_404
  rescue_from ActiveRecord::RecordInvalid, with: :error_400

  def error_404(error)
    render json: { errors: { exception: error.to_s} }, status: :not_found
  end

  def error_400(error)
    render json: { errors: {execption: error.to_s} }, status: 400
  end
end
