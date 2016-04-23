class RemoveLevelFormSchedule < ActiveRecord::Migration
  def change
    remove_column :schedules, :level
  end
end
