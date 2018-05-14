class Admin::ConvenientsController < ApplicationController
  before_action :convenient_params, only: %i[create update]

  def index
    convenients = Convenient.all
    render json: convenients, status: :ok
  end

  def create
    convenient = Convenient.new(convenient_params)
    if (convenient.save)
      render json: { convenient: convenient, status: :ok }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  def update
    convenient = Convenient.find(params[:id])
    convenient.update(convenient_params)
    render json: { convenient: convenient, status: :ok}
  end

  def destroy
    convenient = Convenient.find(params[:id])
    convenient.destroy
    render json: { convenient: convenient, status: :ok }
  end

  private

  def convenient_params
    params.require(:convenient).permit(:name, :description)
  end
end
