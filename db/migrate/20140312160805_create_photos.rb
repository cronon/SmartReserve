class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.timestamps
    end
    add_reference :photos, :club, index: true
  end
end
