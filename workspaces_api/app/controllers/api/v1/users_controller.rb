class Api::V1::UsersController < ApplicationController
  before_action :user_params, only: %i[create update]

  PROVIDER_FACEBOOK = 'Facebook'.freeze
  PROVIDER_BOTH = 'Both'.freeze

  def index; end

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.provider == PROVIDER_FACEBOOK
      user.update(password: params[:user][:password], provider: PROVIDER_BOTH)
      render json: { user: user, status: :ok, message: 'Email account has been already registerd by Facebook' }
    else
      user = User.new(user_params)
      user.confirm_token = SecureRandom.hex(8)
      user.provider = 'Email'
      if user.save
        render json: { user: user, status: :ok }
        user.send_activation_email
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end
  end

  def show
    retturn unless params[:id]
    @user = User.find_by(confirm_token: params[:id])
    if @user
      render json: { user: @user, status: :ok }
    else
      render json: { status: :not_found }
    end
  end

  def confirm_email
    @user = User.find_by(confirm_token: params[:id])
    if @user
      if @user.active_email?
        render json: { user: @user, status: :ok }
      else
        render json: { user: @user, status: :unprocessable_entity }
        user.send_activation_email
      end
    else
      render json: { status: :not_found }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
