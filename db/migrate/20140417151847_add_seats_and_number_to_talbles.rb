class AddSeatsAndNumberToTalbles < ActiveRecord::Migration
  def change
    add_column :tables, :number, :integer
    add_column :tables, :seats, :integer
  end
end
