class AddAdditionalPhonesToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :additional_phones, :string
  end
end
