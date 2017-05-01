class CreatePurchaseProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :purchase_products do |t|
      t.integer :amount
      t.references :purchase, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
