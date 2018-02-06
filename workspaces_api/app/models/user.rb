class User < ApplicationRecord
  has_many :workspaces
  has_many :orders
  has_many :favorites
  has_many :comments
end
