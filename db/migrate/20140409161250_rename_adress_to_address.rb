class RenameAdressToAddress < ActiveRecord::Migration
  def change
    Club.connection.execute("ALTER TABLE clubs RENAME COLUMN adress TO address")
    #rename_column :clubs, :adress, :address
  end
end
