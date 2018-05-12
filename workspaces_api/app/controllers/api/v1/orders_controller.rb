class Api::V1::OrdersController < ApplicationController
  WAITING_STATUS = 'waiting'.freeze
  ACCEPT_STATUS = 'accept'.freeze
  CLEAR_STATUS = 'clear'.freeze
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
      orders = Order.where(workspace_id: params[:id], status: WAITING_STATUS).order(created_at: :desc)
    else
      orders = Order.where(workspace_id: params[:id]).order(status: :asc, created_at: :desc)
    end
    render json: orders, status: :ok
  end

  def accept_order
    order = Order.find(params[:id])
    order.update(status: ACCEPT_STATUS)
    workspace_id = order.workspace_id
    WorkspaceType.update_available_table(order.workspace_type_id, order.quantity)
    user = order.user_id
    user_email = User.find(user).email
    Order.send_confirm_order_email(user_email, order)
    all_orders = Order.where(workspace_id: order.workspace_id).order(status: :asc, created_at: :desc)
    render json: all_orders, status: :ok
  end

  def clear_order
    order = Order.find(params[:id])
    order.update(status: CLEAR_STATUS)
    user = order.user_id
    user_email = User.find(user).email
    Order.send_clear_order_email(user_email, order)
    all_orders = Order.where(workspace_id: order.workspace_id).order(status: :asc, created_at: :desc)
    render json: all_orders, status: :ok
  end
  private

  def order_params
    params.require(:order).permit(:name, :time_start, :time_end, :quantity, :workspace_type_id, :workspace_id, :user_id)
  end
end
