class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :description
      t.timestamps
    end
    add_reference :comments, :club, :index => true
    add_reference :comments, :user
  end
end
