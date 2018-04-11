class WorkspaceTypeSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :workspace
  belongs_to :type
end
