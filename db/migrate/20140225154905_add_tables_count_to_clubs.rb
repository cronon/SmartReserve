class AddTablesCountToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :tables_count, :integer
  end
end
