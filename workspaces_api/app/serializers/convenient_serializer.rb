class ConvenientSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_many :workspace_convenients
end
