class WorkspaceSerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :comments
  has_many :workspace_convenients, if: :is_detail?
  has_many :workspace_images, if: :is_detail?
  has_many :workspace_types, if: :is_detail?

  def attributes(*args)
    object.attributes.symbolize_keys
  end

  def is_detail?
    @instance_options[:full_info]
  end
end
