class AddColumnPriceToWorkspaceTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :workspace_types, :price_hour, :string
    add_column :workspace_types, :price_day, :string
    add_column :workspace_types, :price_week, :string
    add_column :workspace_types, :price_month, :string
    add_column :workspace_types, :price_year, :string
    add_column :workspace_types, :unit, :string
  end
end
