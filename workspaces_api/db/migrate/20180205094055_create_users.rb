class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.date :birthday
      t.integer :role
      t.string :avatar
      t.integer :gender
      t.string :confirm_token
      t.datetime :confirm_at
      t.datetime :confirm_send
      t.string :provider
      t.string :uid
      t.string :oauth_token

      t.timestamps
    end
  end
end
