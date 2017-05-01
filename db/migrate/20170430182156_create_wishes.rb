class CreateWishes < ActiveRecord::Migration[5.0]
  def change
    create_table :wishes do |t|

      t.belongs_to :user
      t.belongs_to :product

      t.timestamps
    end
  add_index :wishes, [:user_id, :product_id], unique: true
  end
end
