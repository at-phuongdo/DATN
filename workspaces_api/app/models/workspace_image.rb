class WorkspaceImage < ApplicationRecord
  belongs_to :workspace

  def self.create_workspace_photos(photos, workspace_id)
    photos.each do |photo|
      WorkspaceImage.create(images: photo, workspace_id: workspace_id)
    end
  end
end
