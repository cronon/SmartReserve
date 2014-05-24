class CreateCategoryLinks < ActiveRecord::Migration
  def change
    create_table :category_links do |t|
      t.string :name
      t.timestamps
    end
  end
end
