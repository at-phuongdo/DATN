class Api::V1::OrdersController < ApplicationController
  WAITING_STATUS = 'waiting'.freeze
  ACCEPT_STATUS = 'accept'.freeze
  before_action :order_params, only: :create
  def create
    order = Order.new(order_params)
    order.status = WAITING_STATUS
    if order.save
      render json: order, status: :ok
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  def order_of_workspace
    if params[:status] == WAITING_STATUS
      orders = Order.where(workspace_id: params[:id], status: WAITING_STATUS)
    else
      orders = Order.where(workspace_id: params[:id])
    end
    render json: orders, status: :ok
  end

  def accept_order
    order = Order.find(params[:id])
    order.update(status: ACCEPT_STATUS)
    all_orders = Order.where(workspace_id: params[:id])
    render json: all_orders, status: :ok
  end

  private

  def order_params
    params.require(:order).permit(:name, :time_start, :time_end, :quantity, :workspace_type_id, :workspace_id, :user_id)
  end
end
