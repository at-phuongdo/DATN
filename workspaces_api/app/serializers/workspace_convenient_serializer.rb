class WorkspaceConvenientSerializer < ActiveModel::Serializer
  attributes :id, :convenient_id
  belongs_to :convenient
  belongs_to :workspace
end
