class Api::V1::CommentsController < ApplicationController
  before_action :current_workspace, only: %i[index create update]
  before_action :comment_params, only: %i[create]

  def index
    comments = Comment.where(workspace_id: @workspace.id).order(updated_at: :desc)
    render json: comments, status: :ok
  end

  def create
    comment = Comment.new(comment_params)
    comment.workspace_id = @workspace.id
    if comment.save
      comments = Comment.where(workspace_id: @workspace.id).order(updated_at: :desc)
      rating = @workspace.rating
      new_rating = (rating * (comments.length - 1) + params[:rating]) / comments.length
      new_rating = "%.0f" % new_rating
      @workspace.update(rating: new_rating.to_i)
      render json: comments, status: :ok
    else
      comments = Comment.where(workspace_id: @workspace.id).order(updated_at: :desc)
      render json: comments, adapter: :json, each_serializer: CommentSerializer, meta: { status: :ok, message: 'Had been commented' }
    end
  end

  def update
    comment = Comment.find(params[:comment][:id])
    if comment.update(comment_params)
      index
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    workspace_id = comment.workspace_id
    comment.destroy
    comments = Comment.where(workspace_id: workspace_id).order(updated_at: :desc)
    render json: comments, status: :ok
  end

  private

  def current_workspace
    @workspace = Workspace.find_by(friendly_url: params[:name])
  end

  def comment_params
    params.require(:comment).permit(:rating, :title, :content, :user_id)
  end
end
