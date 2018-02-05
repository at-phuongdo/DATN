class CreateWorkspaceConvenients < ActiveRecord::Migration[5.1]
  def change
    create_table :workspace_convenients do |t|
      t.references :convenient, foreign_key: true
      t.references :workspace, foreign_key: true

      t.timestamps
    end
  end
end
