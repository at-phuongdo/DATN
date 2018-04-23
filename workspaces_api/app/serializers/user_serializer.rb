class UserSerializer < ActiveModel::Serializer
  has_many :workspaces
  has_many :orders
  has_many :favorites
  has_many :comments

  def attributes(*args)
    object.attributes.symbolize_keys
  end
end
