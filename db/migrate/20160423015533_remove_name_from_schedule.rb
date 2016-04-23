class RemoveNameFromSchedule < ActiveRecord::Migration
  def change
    remove_column :schedules, :name
  end
end
