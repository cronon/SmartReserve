class AddMetroStationToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :metro_station, :string
  end
end
