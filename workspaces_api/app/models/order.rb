class Order < ApplicationRecord
  belongs_to :user
  belongs_to :workspace
  belongs_to :workspace_type
  enum status: %w[waiting accept]
end
