class AddStatusNowToTables < ActiveRecord::Migration
  def change
    add_column :tables, :status_now, :string,:default => 'free'
  end
end
