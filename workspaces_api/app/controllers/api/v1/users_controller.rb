class Api::V1::UsersController < ApplicationController
  before_action :user_params, only: %i[create update]
  def index; end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { user: @user, status: :ok }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
