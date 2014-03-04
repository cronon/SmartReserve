class AddTimeFieldsToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :time_waiting, :datetime
    add_column :clubs, :time_before, :datetime
    add_column :clubs, :time_after, :datetime
    add_column :clubs, :time_last, :datetime
    add_column :clubs, :schedule, :string
  end
end
