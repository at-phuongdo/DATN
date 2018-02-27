class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      render json: { user: user, status: :ok }
    end
  end

  def destroy
  end
end
