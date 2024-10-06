class AddClientIdToApartments < ActiveRecord::Migration[7.0]
  def change
    add_column :apartments, :client_id, :bigint
    add_foreign_key :apartments, :clients
  end
end
