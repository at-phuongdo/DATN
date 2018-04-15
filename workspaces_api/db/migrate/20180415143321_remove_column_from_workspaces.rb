class RemoveColumnFromWorkspaces < ActiveRecord::Migration[5.1]
  def change
    remove_column :workspaces, :price_hour, :string
    remove_column :workspaces, :price_day, :string
    remove_column :workspaces, :price_week, :string
    remove_column :workspaces, :price_month, :string
    remove_column :workspaces, :price_year, :string
    remove_column :workspaces, :unit, :string
  end
end
