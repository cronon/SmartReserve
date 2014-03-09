class AddOwnerRefToClubs < ActiveRecord::Migration
  def change
    add_reference :clubs, :owner, index: true
  end
end
