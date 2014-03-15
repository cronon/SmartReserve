class ChangeTimeTypesInClubs < ActiveRecord::Migration
  def change
      remove_column :clubs, :time_waiting, :datetime 
      remove_column :clubs, :time_before, :datetime 
      remove_column :clubs, :time_after, :datetime
      remove_column :clubs, :time_last, :datetime
      add_column :clubs, :time_before, :integer 
      add_column :clubs, :time_after, :integer 
      add_column :clubs, :time_waiting, :integer 
      add_column :clubs, :time_last, :string 
  end
end