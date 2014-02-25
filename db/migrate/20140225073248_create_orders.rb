class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :table, index: true
      t.datetime :since
      t.datetime :until

      t.timestamps
    end
  end
end
