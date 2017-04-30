class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.integer :price, null: false
      t.integer :stock, null: false
      t.integer :offer

      t.timestamps
    end
  end
end
