class ChangeTimesTypeInClubs < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :clubs do |t|
        # #dir.up   { t.change :time_before, :integer }
        # dir.up   { t.change :time_after, :integer }
        # dir.up   { t.change :time_waiting, :integer }
        # dir.up   { t.change :time_last, :string }

        dir.down { t.change :time_waiting, :datetime }
        dir.down { t.change :time_before, :datetime }
        dir.down { t.change :time_after, :datetime }
        dir.down { t.change :time_last, :datetime }
      end
    end
  end
end