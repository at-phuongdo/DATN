class Api::V1::WorkspacesController < ApplicationController
  TOP_REVIEWED = 'top_reviewed'.freeze
  before_action :workspace_params, only: :create
  before_action :current_user, only: %i[create]

  def index
    return unless params[:key] == TOP_REVIEWED
    workspace_ids = Comment.select('workspace_id, COUNT(*) AS review_times').group('workspace_id').order('review_times desc').limit(3).map(&:workspace_id)
    workspaces = Workspace.where(id: workspace_ids)
    render json: workspaces, status: :ok
  end

  def create
    workspace = Workspace.new(workspace_params)
    workspace.user_id = @current_user.id
    if workspace.save
      workspace.update_info
      @current_user.update(role: 'partner')
      WorkspaceImage.create_workspace_photos(params[:photo], workspace.id)
      WorkspaceConvenient.create_workspace_convenient(params[:amenities], workspace.id)
      WorkspaceType.create_workspace_type(params[:nameRoom], params[:numberPeople], params[:price], workspace.id)
      render json: { workspaces: workspace, status: :ok }
    else
      render json: { status: :no_content }
    end
  end

  def show
    workspace = Workspace.find_by(friendly_url: params[:id])
    render json: workspace, full_info: true, status: :ok
  end

  def update
    workspace = Workspace.find(params[:id])
    workspace.update(workspace_params)
    render json: workspace, full_info: true, status: :ok
  end

  def search
    ascii_str = params[:city].mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, "").downcase.to_s.tr(' ', '%')
    search_key = "%#{ascii_str}%"
    workspaces = Workspace.where("address LIKE '#{search_key}'")
    if params[:district] != "undefined"
      workspaces = workspaces.select { |workspace| workspace.address.downcase.include? params[:district].downcase}
    end
    render json: workspaces, full_info: true, status: :ok
  end

  def search_by_name
    search_str = params[:name].downcase.tr(' ', '%')
    search_key = "%#{search_str}%"
    workspaces = Workspace.where("friendly_url LIKE '#{search_key}'").limit(5)
    render json: workspaces, full_info: true, status: :ok
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :avatar, :lat, :lng, :country, :city, :district, :town, :street, :description, :email, :website, :phone, :facebook, :open_mon, :open_tue, :open_wed, :open_thurs, :open_fri, :open_sat, :open_sun)
  end

  def current_user
    @current_user ||= User.find_by(confirm_token: request.headers['AccessToken'])
  end
end
