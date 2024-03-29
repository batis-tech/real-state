class CreateProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :properties do |t|
      t.references :account
      t.string :name
      t.string :address
      t.integer :price
      t.integer :room
      t.string :bathrooms
      t.string :photo

      t.timestamps
    end
  end
end
