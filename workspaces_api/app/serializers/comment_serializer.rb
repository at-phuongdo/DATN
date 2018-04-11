class CommentSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :rating, :user_id, :workspace_id
  belongs_to :user
  belongs_to :workspace
end
