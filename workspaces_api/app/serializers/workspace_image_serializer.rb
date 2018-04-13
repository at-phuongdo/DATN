class WorkspaceImageSerializer < ActiveModel::Serializer
  attributes :id, :images
  belongs_to :workspace
end
