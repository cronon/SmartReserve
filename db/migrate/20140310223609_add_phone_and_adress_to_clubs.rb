class AddPhoneAndAdressToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :phone, :string
    add_column :clubs, :adress, :string
  end
end
