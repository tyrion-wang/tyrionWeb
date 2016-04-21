class ScheduleAddType < ActiveRecord::Migration
  def change
    add_column :schedules, :mType, :integer
  end
end
