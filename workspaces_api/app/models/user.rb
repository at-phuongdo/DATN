class User < ApplicationRecord
  has_many :workspaces
  has_many :orders
  has_many :favorites
  has_many :comments
  has_secure_password

  # validates :email, uniqueness: true
  # validates :password, presence: true, on: :create
end
