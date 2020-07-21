# Authenticates User's token
class UserAuthService
  def initialize(token)
    @token = token || ''
  end

  def verify
    User.current = User.find_by(token: @token)
    User.current.present?
  end
end
