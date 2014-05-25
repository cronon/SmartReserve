class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :email
      t.string :phone
      t.string :name

      t.timestamps
    end
  end
end
