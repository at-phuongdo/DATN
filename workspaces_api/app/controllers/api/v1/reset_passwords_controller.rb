class Api::V1::ResetPasswordsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user
      render json: { status: :ok }
      user.reset_password_token
      user.send_resetpassword_email
    else
      render json: { status: :not_found }
    end
  end

  def update
    user = User.find_by(password_reset_token: params[:id])
    if user
      user.update(password: params[:password])
      render json: { status: :ok }
    else
      render json: { status: :not_found }
    end
  end
end
