class AddReferencesBetweenClbsAndProperties < ActiveRecord::Migration
  def change
    create_join_table :clubs, :properties do |t| 
      t.index :club_id
      t.index :property_id
    end
  end
end
