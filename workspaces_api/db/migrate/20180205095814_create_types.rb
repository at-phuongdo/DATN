class CreateTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :types do |t|
      t.string :name
      t.integer :quantity
      t.integer :quantity_desk

      t.timestamps
    end
  end
end
