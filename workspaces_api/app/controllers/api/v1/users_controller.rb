class Api::V1::UsersController < ApplicationController
  before_action :user_params, only: %i[create update]
  def index; end

  def create
    @user = User.new(user_params)
    @user.confirm_token = User.create_token
    if @user.save
      render json: { user: @user, status: :ok }
      @user.send_activation_email
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    if params[:id]
      @user = User.find_by(confirm_token: params[:id])
      if @user
        render json: { user: @user, status: :ok }
      else
        render json: { status: :not_found }
      end
    end
  end

  def confirm_email
    @user = User.find_by(confirm_token: params[:id])
    if @user.active_email?
      render json: { user: @user, status: :ok }
    else
      user.send_activation_email
      render json: { user: @user, status: :unprocessable_entity }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
