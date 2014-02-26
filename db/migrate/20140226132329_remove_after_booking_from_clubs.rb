class RemoveAfterBookingFromClubs < ActiveRecord::Migration
  def change
    remove_column :clubs, :after_booking, :integer
  end
end
