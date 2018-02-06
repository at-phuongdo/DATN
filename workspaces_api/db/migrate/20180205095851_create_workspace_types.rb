class CreateWorkspaceTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :workspace_types do |t|
      t.references :workspace, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end
