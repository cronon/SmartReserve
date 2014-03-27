class RemoveNameFromProperty < ActiveRecord::Migration
  def change
  	remove_column :properties, :name,    :string
  	add_column	  :properties, :name_ru, :string
  	add_column	  :properties, :name_en, :string
  	remove_column :properties, :kind,    :string
  	add_column	  :properties, :kind_ru, :string
  	add_column	  :properties, :kind_en, :string
  end
end
