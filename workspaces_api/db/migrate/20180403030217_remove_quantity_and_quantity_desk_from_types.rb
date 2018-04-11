class RemoveQuantityAndQuantityDeskFromTypes < ActiveRecord::Migration[5.1]
  def change
    remove_column :types, :quantity, :integer
    remove_column :types, :quantity_desk, :integer
  end
end
