class AddIsCertifiedToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :is_certified, :boolean, :default => false
  end
end
