class AddEmailToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :email, :string
  end
end
