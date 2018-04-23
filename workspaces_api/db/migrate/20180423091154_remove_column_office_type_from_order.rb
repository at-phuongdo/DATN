class RemoveColumnOfficeTypeFromOrder < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :office_type, :integer
  end
end
