class TypeSerializer < ActiveModel::Serializer
  attributes :id
  has_many :workspace_types
end
