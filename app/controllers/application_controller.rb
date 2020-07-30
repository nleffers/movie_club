# Application Controller
class ApplicationController < ActionController::API
  before_action :verify_authentication_token

  def verify_authentication_token
    @token = request.headers.env['HTTP_X_AUTH_TOKEN'] || ''

    render json: {}, status: 401 unless token_verified?
  end

  private

  def token_verified?
    User.current = User.find_by(token: @token)
    User.current.present?
  end
end
