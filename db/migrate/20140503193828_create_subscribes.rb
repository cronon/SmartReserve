class CreateSubscribes < ActiveRecord::Migration
  def change
    create_table :subscribes do |t|
      t.belongs_to :club
      t.belongs_to :user
      t.timestamps
    end
  end
end
