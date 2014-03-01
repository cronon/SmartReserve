class RemoveAverageTImeFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :average_time, :datetime
  end
end
