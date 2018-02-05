class CreateConvenients < ActiveRecord::Migration[5.1]
  def change
    create_table :convenients do |t|
      t.string :name
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
