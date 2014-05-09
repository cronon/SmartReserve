class AddAvatarToNews < ActiveRecord::Migration
  def change
    add_column :news, :avatar, :string
  end
end
