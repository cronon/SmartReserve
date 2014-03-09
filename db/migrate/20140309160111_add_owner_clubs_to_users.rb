class AddOwnerClubsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :owner_clubs, :boolean, :default => false
  end
end
