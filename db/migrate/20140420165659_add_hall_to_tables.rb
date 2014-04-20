class AddHallToTables < ActiveRecord::Migration
  def change
    add_column :tables, :hall, :string, :default => 'Некурящий'
  end
end
