class Admin::ConvenientsController < ApplicationController
  def index
    convenients = Convenient.all
    render json: convenients, status: :ok
  end
end
