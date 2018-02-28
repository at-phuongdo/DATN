class User < ApplicationRecord
  has_many :workspaces
  has_many :orders
  has_many :favorites
  has_many :comments
  has_secure_password

  validates :email, uniqueness: true
  validates :email, presence: true

  def self.create_token
    SecureRandom.urlsafe_base64.to_s
  end
end
