class Workspace < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :workspace_convenients
  has_many :workspace_images
  has_many :workspace_types
  has_many :comments
  has_many :favorites
end
