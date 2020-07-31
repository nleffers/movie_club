# Custom exception handling for login/validation
module ExceptionHandler
  extend ActiveSupport::Concern

  class DecodeError < StandardError; end
  class ExpiredSignature < StandardError; end

  included do
    rescue_from ExceptionHandler::DecodeError, with: :unauthorized_request
    rescue_from ExceptionHandler::ExpiredSignature, with: :unauthorized_request
  end

  private

  def unauthorized_request(e)
    render json: { message: e.message }, status: :unauthorized
  end
end
