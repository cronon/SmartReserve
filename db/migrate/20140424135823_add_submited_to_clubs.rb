class AddSubmitedToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :submited, :boolean, :default=>false
  end
end
