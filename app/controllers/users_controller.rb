# Controller for Users
class UsersController < ApplicationController
  before_action :get_user, only: %i[login update destroy]

  def new; end

  def create
    User.current = User.create(user_params)

    redirect_to root_path
  end

  def login
    User.current = @user

    redirect_to root_path
  end

  def index
    User.all
  end

  def show
    User.joins(:movies).find(params[:id])
  end

  def show_current_user
    User.current
  end

  def update
    @user.update(user_params)

    @user
  end

  def destroy
    @user.destroy

    head :ok
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:id,
                  :username,
                  :email,
                  :first_name,
                  :last_name,
                  :email_notifications)
  end
end
