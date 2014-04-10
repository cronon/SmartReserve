class RemoveClubFromPhoto < ActiveRecord::Migration
  def change
  	remove_column :photos, :club_id, :integer
  end
end
