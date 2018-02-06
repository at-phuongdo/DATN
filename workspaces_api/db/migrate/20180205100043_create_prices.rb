class CreatePrices < ActiveRecord::Migration[5.1]
  def change
    create_table :prices do |t|
      t.string :price_hour
      t.string :price_day
      t.string :price_month
      t.string :price_year
      t.string :unit
      t.references :workspace, foreign_key: true

      t.timestamps
    end
  end
end
