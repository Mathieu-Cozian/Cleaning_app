class AddStatusToCleaners < ActiveRecord::Migration[7.0]
  def change
    change_column :cleaners, :status, :integer, using: 'status::integer'
  end
end
