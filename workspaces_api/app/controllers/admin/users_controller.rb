class Admin::UsersController < ApplicationController
  def index
    users = User.all
    render json: users, status: :ok
  end

  def login
    user = User.find_by_email(params[:user][:email])
    if user && user.role === 'admin' && user.authenticate(params[:user][:password])
      render json: user, status: :ok
    else
      render json: {status: :unauthorized}
    end
  end
end
