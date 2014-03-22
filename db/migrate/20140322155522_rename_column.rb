class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :clubs, :owner_id, :user_id
  end
end
