class AddDetailsToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :after_booking, :integer
    add_column :clubs, :description, :text
  end
end
