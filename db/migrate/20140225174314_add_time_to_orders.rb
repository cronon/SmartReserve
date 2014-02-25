class AddTimeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :time, :datetime
  end
end
