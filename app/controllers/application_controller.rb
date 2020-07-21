# Application Controller
class ApplicationController < ActionController::API
  before_action :verify_authentication_token

  def verify_authentication_token
    @token = request.headers.env['HTTP_X_AUTH_TOKEN']

    auth = UserAuthService.new(@token)

    render json: {}, status: 401 unless auth.verify
  end
end
