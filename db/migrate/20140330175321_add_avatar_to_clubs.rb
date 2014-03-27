class AddAvatarToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :avatar, :string
  end
end
