class Api::V1::BannersController < ApplicationController
  def index
    banners = Banner.all.order(created_at: :desc).limit(3)
    render json: banners, status: :ok
  end
end
