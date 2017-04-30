class CreateCategoriesProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :categories_products do |t|
      t.references :category, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
