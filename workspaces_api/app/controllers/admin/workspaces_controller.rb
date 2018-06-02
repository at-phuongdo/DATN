class Admin::WorkspacesController < ApplicationController
  def index
    workspaces = Workspace.all
    render json: workspaces, full_info: true, status: :ok
  end

  def show
    workspace = Workspace.find(params[:id])
    render json: workspace, full_info: true, status: :ok
  end

  def destroy
    workspace = Workspace.find(params[:id])
    workspace.destroy
    render json: { status: :ok }
  end
end
