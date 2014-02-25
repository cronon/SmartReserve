class RemoveUntilFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :until, :datetime
  end
end
