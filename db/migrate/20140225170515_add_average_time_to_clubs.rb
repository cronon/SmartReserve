class AddAverageTimeToClubs < ActiveRecord::Migration
  def change
  	add_column :clubs, :average_time, :datetime
  end
end
