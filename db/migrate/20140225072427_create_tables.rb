class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.references :club, index: true

      t.timestamps
    end
  end
end
