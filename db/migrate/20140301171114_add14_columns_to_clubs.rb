class Add14ColumnsToClubs < ActiveRecord::Migration
  def change
    [:mon,:tue,:wed,:thu,:fri,:sat,:sun].each do |day|
      add_column :clubs, (day.to_s+'_opens').to_sym, :string
      add_column :clubs, (day.to_s+'_closes').to_sym, :string
    end
  end
end
