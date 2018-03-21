class Api::V1::SessionsController < ApplicationController
  before_action :facebook_params, only: :login_facebook

  PROVIDER_GMAIL = 'Gmail'.freeze
  PROVIDER_FACEBOOK = 'Facebook'.freeze

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

  def login_facebook
    user = User.find_by_email(params[:session][:email])
    if user
      user.update(uid: params[:session][:uid]) if user.provider == PROVIDER_GMAIL
    else
      user = User.create(facebook_params)
      user.update(provider: PROVIDER_FACEBOOK)
      user.update(confirm_token: SecureRandom.hex(8))
    end
    render json: { user: user, status: :ok }
  end

  private

  def facebook_params
    params.require(:session).permit(:username, :email, :uid, :avatar)
  end
end
