class Api::V1::CommentsController < ApplicationController
  def index
    workspace = Workspace.find_by(friendly_url: params[:name])
    comments = Comment.where(workspace_id: workspace.id)
    render json: comments, status: :ok
  end
end
