class Api::V1::CommentsController < ApplicationController
  before_action :current_workspace, only: %i[index create update]
  before_action :comment_params, only: %i[create]
  before_action :current_user, only: %i[create]

  def index
    comments = Comment.where(workspace_id: @workspace.id).order(updated_at: :desc)
    render json: comments, status: :ok
  end

  def create
    comment = Comment.new(comment_params)
    comment.workspace_id = @workspace.id
    comment.user_id = @current_user.id
    if comment.save!
      index
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if comment.update(comment_params)
      index
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def current_workspace
    @workspace = Workspace.find_by(friendly_url: params[:name])
  end

  def comment_params
    params.require(:comment).permit(:rating, :title, :content)
  end

  def current_user
    @current_user ||= User.find_by(confirm_token: request.headers['AccessToken'])
  end
end
