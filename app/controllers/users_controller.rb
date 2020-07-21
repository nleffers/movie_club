# Controller for Users
class UsersController < ApplicationController
  skip_before_action :verify_authentication_token, only: %i[create login]
  before_action :get_user, only: %i[logout update destroy]

  def create
    @user = User.create(user_params)
    @user.update(token: get_encoded_auth_token)
    User.current = @user

    render json: @user, serializer: User::ShowSerializer
  end

  def login
    User.current = authenticate_user

    render json: @user, serializer: User::ShowSerializer
  end

  def logout
    if @user
      @user.update(token: nil)

      head :ok
    else
      head :forbidden
    end
  end

  def index
    User.all
  end

  def show
    render json: @user, serializer: User::ShowSerializer
  end

  def update
    @user.update(user_params)

    render json: @user, serializer: User::ShowSerializer
  end

  def destroy
    @user.destroy

    head :ok
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def authenticate_user
    return false unless user_authenticated?

    token = get_encoded_auth_token
    @user.update(token: token) unless @user.token == token
    @user
  end

  def user_authenticated?
    user = User.find_by(username: login_params[:username])
    return unless user && user.authenticate(login_params[:password])

    @user = user
    @user.present?
  end

  def get_encoded_auth_token
    if @user&.token
      begin
        JsonWebToken.decode(@user.token)
      rescue ExceptionHandler::ExpiredSignature
        encode_auth_token
      else
        @user.token
      end
    else
      encode_auth_token
    end
  end

  def encode_auth_token
    JsonWebToken.encode({ user_id: @user.id }, Time.now.to_i + YML_VAR['token_expiration'].to_i * 60)
  end

  def user_params
    params.require(:user).permit(:id,
                                 :username,
                                 :password,
                                 :email,
                                 :first_name,
                                 :last_name,
                                 :email_notifications)
  end

  def login_params
    params.require(:login).permit(:username,
                                  :password)
  end
end
