class RemovemTypeFromSchedule < ActiveRecord::Migration
  def change
    remove_column :schedules, :mType
  end
end
