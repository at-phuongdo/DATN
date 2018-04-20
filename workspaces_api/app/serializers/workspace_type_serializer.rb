class WorkspaceTypeSerializer < ActiveModel::Serializer
  belongs_to :workspace
  belongs_to :type

  def attributes(*args)
    object.attributes.symbolize_keys
  end
end
