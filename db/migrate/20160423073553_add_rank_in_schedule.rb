class AddRankInSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :rank, :integer
  end
end
