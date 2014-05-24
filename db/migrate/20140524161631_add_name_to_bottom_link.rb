class AddNameToBottomLink < ActiveRecord::Migration
  def change
  	add_column :bottom_links, :name, :string
  end
end
