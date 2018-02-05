class User < ApplicationRecord
  has_many :workspaces
  has_many :orders
end
