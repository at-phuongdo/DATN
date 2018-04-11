class WorkspaceConvenientSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :convenient
  belongs_to :workspace
end
