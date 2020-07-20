# Custom exception handling for login/validation
module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  class DecodeError < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :unauthorized_request
    rescue_from ExceptionHandler::InvalidToken, with: :unauthorized_request
    rescue_from ExceptionHandler::DecodeError, with: :unauthorized_request
    rescue_from ExceptionHandler::ExpiredSignature, with: :unauthorized_request
  end

  private

  def unauthorized_request(e)
    render json: { message: e.message }, status: :unauthorized
  end
end
