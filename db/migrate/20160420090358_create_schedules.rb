class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :name
      t.integer :type
      t.integer :state

      t.timestamps null: false
    end
  end
end
