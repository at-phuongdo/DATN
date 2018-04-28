class AddColumnAvailableToWorkspaceType < ActiveRecord::Migration[5.1]
  def change
    add_column :workspace_types, :available, :integer
  end
end
