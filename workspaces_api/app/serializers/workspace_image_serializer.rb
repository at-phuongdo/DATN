class WorkspaceImageSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :workspace
end
