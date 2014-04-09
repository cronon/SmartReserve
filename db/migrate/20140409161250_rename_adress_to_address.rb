class RenameAdressToAddress < ActiveRecord::Migration
  def change
    Club.connection.execute('ALTER TABLE clubs RENAME COLUMN adress TO address')
  end
end
