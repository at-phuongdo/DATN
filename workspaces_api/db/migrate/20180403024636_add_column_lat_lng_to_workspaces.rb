class AddColumnLatLngToWorkspaces < ActiveRecord::Migration[5.1]
  def change
    add_column :workspaces, :lng, :float, after: :address
    add_column :workspaces, :lat, :float, after: :address
  end
end
