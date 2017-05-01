class ChangeWishes < ActiveRecord::Migration[5.0]
  def change
    change_table :wishes do |t|
      t.remove :user_id, :product_id
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
    end
  add_index :wishes, [:user_id, :product_id], unique: true
  end
end
