class Api::V1::WorkspacesController < ApplicationController
  TOP_REVIEWED = 'top_reviewed'.freeze
  def index
    if params[:key] == TOP_REVIEWED
      workspace_ids = Comment.select('workspace_id, COUNT(*) AS review_times').group('workspace_id').order('review_times desc').limit(3).map(&:workspace_id)
      workspaces = Workspace.where(id: workspace_ids)
      render json: { workspaces: workspaces, status: :ok }
   end
 end
end
