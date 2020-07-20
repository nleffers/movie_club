# Application Controller
class ApplicationController < ActionController::API
  # include ActionController::RequestForgeryProtection
  # include ExceptionHandler

  # before_action :authenticate_request
  # protect_from_forgery unless: -> { @current_user }
  # attr_reader :current_user

  # private

  # def authenticate_request
  #   result = AuthorizeApiRequest.call(request.headers).result
  #   if result
  #     @current_user = result
  #   else
  #     render json: { error: 'Invalid Token' }, status: 401
  #   end
  # end
end
