class Api::V1::SessionsController < ApplicationController
  before_action :facebook_params, only: :login_facebook

  PROVIDER_EMAIL = 'Email'.freeze
  PROVIDER_FACEBOOK = 'Facebook'.freeze
  PROVIDER_BOTH = 'Both'.freeze

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      render json: user, status: :ok
    else
      render json: { status: :unauthorized }
    end
  end

  def login_facebook
    user = User.find_by_email(params[:session][:email])
    if user
      user.update(uid: params[:session][:uid], provider: PROVIDER_BOTH, avatar: params[:session][:avatar]) if user.provider == PROVIDER_EMAIL
    else
      user = User.create(facebook_params)
      user.update(provider: PROVIDER_FACEBOOK, confirm_at: Time.now)
      user.update(confirm_token: SecureRandom.hex(8))
    end
    render json: user, status: :ok
  end

  private

  def facebook_params
    params.require(:session).permit(:username, :email, :uid, :avatar)
  end
end
