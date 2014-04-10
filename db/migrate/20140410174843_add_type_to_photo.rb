class AddTypeToPhoto < ActiveRecord::Migration
  def change
    add_reference :photos, :imageable, polymorphic: true
  end
end
