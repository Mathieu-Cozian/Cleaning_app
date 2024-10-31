class AddBooleanColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_column :users, :is_client, :boolean, default: false
    add_column :users, :is_cleaner, :boolean, default: false
  end
end
