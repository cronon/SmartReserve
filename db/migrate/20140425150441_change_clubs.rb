class ChangeClubs < ActiveRecord::Migration
  def change
  	[:mon,:tue,:wed,:thu,:fri,:sat,:sun].each do |day|
      change_column :clubs, (day.to_s+'_opens').to_sym, :string, :default => '08:00'
      change_column :clubs, (day.to_s+'_closes').to_sym, :string, :default => '23:00'
    end
  end
end
