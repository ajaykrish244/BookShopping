class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.string :publisher
      t.integer :price
      t.integer :quantity

      t.timestamps
    end
  end
end
