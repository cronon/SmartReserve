class AddCityToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :city, :string
  end
end
