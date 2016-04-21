class AddOwnerToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :ownerId, :integer
  end
end
