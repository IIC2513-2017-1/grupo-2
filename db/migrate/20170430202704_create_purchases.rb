class CreatePurchases < ActiveRecord::Migration[5.0]
  def change
    create_table :purchases do |t|
      t.float :total
      t.integer :nproducts
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
