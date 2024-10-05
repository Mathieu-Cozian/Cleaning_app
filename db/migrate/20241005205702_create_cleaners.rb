class CreateCleaners < ActiveRecord::Migration[7.0]
  def change
    create_table :cleaners do |t|
      t.string :address
      t.string :status

      t.timestamps
    end
  end
end
