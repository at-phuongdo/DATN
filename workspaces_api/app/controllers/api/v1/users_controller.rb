class Api::V1::UsersController < ApplicationController
  before_action :user_params, only: %i[create update]
  def index; end

  def create
    puts "=========== #{params.inspect}"
    @user = User.new(user_params)
    if @user.save
      render json: { user: @user, status: 200 }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :firstname)
  end
end
