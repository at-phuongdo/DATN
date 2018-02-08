class WorkspaceType < ApplicationRecord
  belongs_to :workspace
  belongs_to :type
end
