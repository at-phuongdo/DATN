class AddUserToWorkspaces < ActiveRecord::Migration[5.1]
  def change
    add_reference :workspaces, :user, foreign_key: true
  end
end
