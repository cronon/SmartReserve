class CreateBottomLinks < ActiveRecord::Migration
  def change
    create_table :bottom_links do |t|
      t.string :src
      t.belongs_to :category_link
      t.timestamps
    end
  end
end
