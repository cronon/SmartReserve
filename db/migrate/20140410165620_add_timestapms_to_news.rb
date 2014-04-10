class AddTimestapmsToNews < ActiveRecord::Migration
  def change
    change_table(:news){|t| t.timestamps}
  end
end
