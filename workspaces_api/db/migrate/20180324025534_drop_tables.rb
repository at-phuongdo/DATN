class DropTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :prices
    drop_table :opening_hours
  end
end
