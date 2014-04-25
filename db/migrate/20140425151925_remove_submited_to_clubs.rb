class RemoveSubmitedToClubs < ActiveRecord::Migration
  def change
  	remove_column :clubs, :submited, :boolean
  end
end
