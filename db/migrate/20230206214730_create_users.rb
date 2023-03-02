class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest
      t.string :name, null: false
      t.string :email, null: false
      t.text :address
      t.string :credit_card_number
      t.string :phone_number

      t.timestamps
    end
  end
end
