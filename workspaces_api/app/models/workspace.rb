class Workspace < ApplicationRecord
  belongs_to :user
  has_many :orders
  has_many :workspace_convenients
  has_many :workspace_images
  has_many :workspace_types
  has_many :comments
  has_many :favorites
  has_many :convenient, through: :workspace_convenients

  def update_info
    address = street + ',' + town + ',' + district + ',' + city + ',' + country
    friendly_url = name.parameterize
    update(address: address, friendly_url: friendly_url)
  end
end
