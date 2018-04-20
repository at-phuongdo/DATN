class ConvenientSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :workspace_convenients
end
