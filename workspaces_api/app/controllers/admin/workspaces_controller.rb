class Admin::WorkspacesController < ApplicationController
  def index
    workspaces = Workspace.all
    render json: workspaces, status: :ok
  end
end
