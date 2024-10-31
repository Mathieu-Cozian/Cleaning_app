class RemoveDuplicateRolesFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :admin, :boolean if column_exists?(:users, :admin)
    remove_column :users, :client, :boolean if column_exists?(:users, :client)
    remove_column :users, :cleaner, :boolean if column_exists?(:users, :cleaner)
  end
end
