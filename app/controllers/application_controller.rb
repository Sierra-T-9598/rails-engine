class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_error_404
  rescue_from ActiveRecord::RecordInvalid, with: :handle_error_400

  def handle_error_404(error)
    render json: { errors: { exception: error.to_s} }, status: :not_found
  end

  def handle_error_400(error)
    render json: { errors: {execption: error.to_s} }, status: 400
  end
end
