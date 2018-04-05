class WorkspaceConvenient < ApplicationRecord
  belongs_to :convenient
  belongs_to :workspace

  def self.create_workspace_convenient(convenients, workspace_id)
    convenients.each do |convenient|
      WorkspaceConvenient.create(convenient_id: convenient, workspace_id: workspace_id)
    end
  end
end
