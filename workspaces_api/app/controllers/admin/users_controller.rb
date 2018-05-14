class Admin::UsersController < ApplicationController
  before_action :user_params, only: %i[create update]

  PROVIDER_FACEBOOK = 'Facebook'.freeze
  PROVIDER_EMAIL = 'Email'.freeze
  PROVIDER_BOTH = 'Both'.freeze

  def index
    users = User.all.order(created_at: :desc)
    render json: users, status: :ok
  end

  def login
    user = User.find_by_email(params[:user][:email])
    if user && user.role == 'admin' && user.authenticate(params[:user][:password])
      render json: user, status: :ok
    else
      render json: { status: :unauthorized }
    end
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.provider == PROVIDER_FACEBOOK
      user.update(provider: PROVIDER_BOTH)
      user.update(user_params)
      render json: { user: user, status: :ok, message: 'Email account has been already registerd by Facebook' }
    else
      user = User.new(user_params)
      user.confirm_token = SecureRandom.hex(8)
      user.provider = PROVIDER_EMAIL
      if user.save
        render json: { user: user, status: :ok }
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    render json: { user: user, status: :ok }
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { user: user, status: :ok }
  end

  def user_params
    params.require(:user).permit(:username, :role, :email, :first_name, :last_name, :phone, :birthday, :gender)
  end
end
