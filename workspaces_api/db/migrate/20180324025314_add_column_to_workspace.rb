class AddColumnToWorkspace < ActiveRecord::Migration[5.1]
  def change
    add_column :workspaces, :price_hour, :string
    add_column :workspaces, :price_day, :string
    add_column :workspaces, :price_week, :string
    add_column :workspaces, :price_month, :string
    add_column :workspaces, :price_year, :string
    add_column :workspaces, :unit, :string
    add_column :workspaces, :open_mon, :string
    add_column :workspaces, :open_tue, :string
    add_column :workspaces, :open_wed, :string
    add_column :workspaces, :open_thurs, :string
    add_column :workspaces, :open_fri, :string
    add_column :workspaces, :open_sat, :string
    add_column :workspaces, :open_sun, :string
  end
end
