class OrderSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :workspace
  belongs_to :workspace_type

  def attributes(*args)
    object.attributes.symbolize_keys
  end
end
