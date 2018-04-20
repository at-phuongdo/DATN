class AddColumnToWorkspaces < ActiveRecord::Migration[5.1]
  def change
    add_column :workspaces, :town, :string, after: :district
    add_column :workspaces, :facebook, :string, after: :description
    add_column :workspaces, :phone, :string, after: :description
    add_column :workspaces, :website, :string, after: :description
    add_column :workspaces, :email, :string, after: :description
  end
end
