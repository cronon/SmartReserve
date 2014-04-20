class AddSiteToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :site, :string
  end
end
