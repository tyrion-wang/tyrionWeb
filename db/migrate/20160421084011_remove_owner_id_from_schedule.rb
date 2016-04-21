class RemoveOwnerIdFromSchedule < ActiveRecord::Migration
  def change
    remove_column :schedules, :ownerId
  end
end
