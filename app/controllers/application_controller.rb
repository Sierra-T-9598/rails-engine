class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :handle_error_404

  def handle_error_404(error)
    render json: { errors: { exception: error.to_s} }, status: :not_found
  end
end
