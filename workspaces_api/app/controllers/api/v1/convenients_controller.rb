class Api::V1::ConvenientsController < ApplicationController
  def index
    convenients = Convenient.all
    if convenients
      render json: { convenients: convenients, status: :ok }
    else
      render json: { status: :not_found }
    end
  end
end
