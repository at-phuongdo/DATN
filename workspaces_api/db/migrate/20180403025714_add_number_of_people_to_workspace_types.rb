class AddNumberOfPeopleToWorkspaceTypes < ActiveRecord::Migration[5.1]
  def change
    add_column :workspace_types, :number_of_people, :integer, after: :type_id
    add_column :workspace_types, :name, :string, after: :type_id
  end
end
