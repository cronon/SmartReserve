class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :phone
      t.boolean :is_phone
      t.string :email
      t.boolean :is_email
      t.belongs_to :club

      t.timestamps
    end
  end
end
