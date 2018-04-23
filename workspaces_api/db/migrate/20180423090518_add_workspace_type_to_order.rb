class AddWorkspaceTypeToOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :workspace_type, foreign_key: true
  end
end
