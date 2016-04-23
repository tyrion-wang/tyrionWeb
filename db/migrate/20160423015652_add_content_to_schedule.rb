class AddContentToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :content, :string
    add_column :schedules, :level, :integer
    add_column :schedules, :isFinish, :boolean
  end
end
