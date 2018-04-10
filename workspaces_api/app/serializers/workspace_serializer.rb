class WorkspaceSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :rating, :price_day
  belongs_to :user
  has_many :comments
end
