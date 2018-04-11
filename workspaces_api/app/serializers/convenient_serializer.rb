class ConvenientSerializer < ActiveModel::Serializer
  attributes :id
  has_many :workspace_convenients
end
