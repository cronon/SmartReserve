class ChangeAverageTimeType < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :clubs do |t|
        dir.up   { t.change :average_time, :integer }
        dir.down { t.change :average_time, :datetime }
      end
    end
  end
end
