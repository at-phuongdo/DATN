class CreateOpeningHours < ActiveRecord::Migration[5.1]
  def change
    create_table :opening_hours do |t|
      t.string :mon
      t.string :tue
      t.string :wed
      t.string :thurs
      t.string :fri
      t.string :sat
      t.string :sun
      t.references :workspace, foreign_key: true

      t.timestamps
    end
  end
end
