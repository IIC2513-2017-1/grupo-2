class AddPaymentConfirmationToPurchases < ActiveRecord::Migration[5.0]
  def change
    add_column :purchases, :payment_confirmed, :boolean, default: false
  end
end
