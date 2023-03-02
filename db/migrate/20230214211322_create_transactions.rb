class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :transaction_number, null: false
      t.string :credit_card_number, null: false
      t.text :address, null: false
      t.string :phone_number, null: false
      t.integer :quantity, null: false
      t.float :total_cost, null: false

      t.timestamps
    end
  end
end
