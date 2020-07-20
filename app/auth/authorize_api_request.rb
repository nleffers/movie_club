# Authenticates token when passed in headers to /validate route
class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  def user
    @user ||= User.find_by(id: decoded_auth_token[:user_id]) if decoded_auth_token
    return @user if @user && tokens_match?
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  rescue ExceptionHandler::ExpiredSignature
    User.where(token: http_auth_header).update_all(token: nil)
    raise ExceptionHandler::ExpiredSignature => e
  end

  def http_auth_header
    return headers['Authorization'].split(' ').last if headers['Authorization'].present?
  end

  def tokens_match?
    @user.token == http_auth_header
  end
end
