class RemoveSinceFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :since, :datetime
  end
end
