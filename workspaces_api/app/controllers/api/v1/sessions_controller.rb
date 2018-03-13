class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      if user.confirm_at
        render json: { user: user, status: :ok }
      else
        render json: { user: user, status: :no_content }
      end
    else
      render json: { status: :unauthorized }
    end
  end
end
