class ChangeColumnInOrder < ActiveRecord::Migration[5.1]
  def change
    change_column :orders, :time_start, :string
    change_column :orders, :time_end, :string
  end
end
