class AddComlumnFullnameToOrder < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :name, :string, after: :id
  end
end
