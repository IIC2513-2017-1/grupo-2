class AddDefaultOfferToProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :offer, :integer, default: 0
  end
end
