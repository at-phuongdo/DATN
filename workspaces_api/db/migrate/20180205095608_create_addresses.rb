class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :latitude
      t.string :longitude
      t.references :workspace, foreign_key: true

      t.timestamps
    end
  end
end
