class WorkspaceTypeSerializer < ActiveModel::Serializer
  attributes :type_id, :name, :number_of_people
  belongs_to :workspace
  belongs_to :type
end
