class AddPaymentMethodsToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :payment_methods, :string
  end
end
