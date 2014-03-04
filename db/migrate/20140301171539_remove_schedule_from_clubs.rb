class RemoveScheduleFromClubs < ActiveRecord::Migration
  def change
    remove_column :clubs, :schedule, :string
  end
end
