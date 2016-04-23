class RemoveStateFromSchedule < ActiveRecord::Migration
  def change
    remove_column :schedules, :state
  end
end
