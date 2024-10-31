class AddRolesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin, :boolean, default: false unless column_exists?(:users, :admin)
    add_column :users, :client, :boolean, default: false unless column_exists?(:users, :client)
    add_column :users, :cleaner, :boolean, default: false unless column_exists?(:users, :cleaner)
  end
end
