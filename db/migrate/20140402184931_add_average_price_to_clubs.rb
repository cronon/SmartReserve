class AddAveragePriceToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :average_price, :integer
  end
end
