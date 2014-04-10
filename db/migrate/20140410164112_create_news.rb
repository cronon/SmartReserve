class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.references :club, index: true
      t.text :description
      t.string :title
    end
  end
end
