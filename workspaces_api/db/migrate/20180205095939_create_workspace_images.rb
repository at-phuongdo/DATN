class CreateWorkspaceImages < ActiveRecord::Migration[5.1]
  def change
    create_table :workspace_images do |t|
      t.string :images
      t.references :workspace, foreign_key: true

      t.timestamps
    end
  end
end
