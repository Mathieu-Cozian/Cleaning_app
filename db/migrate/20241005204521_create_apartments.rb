class CreateApartments < ActiveRecord::Migration[7.0]
  def change
    create_table :apartments do |t|
      t.string :address
      t.string :address_url
      t.integer :price_per_cleaning
      t.integer :sqm
      t.integer :number_of_rooms
      t.timestamps
    end
    add_column :users, :surname, :string
    add_column :users, :name, :string
  end
end
