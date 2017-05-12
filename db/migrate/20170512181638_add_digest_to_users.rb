class AddDigestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :password_digest, :string

    User.find_each do |u|
      u.password = u.read_attribute(:password)
      u.save
    end

    remove_column :users, :password
  end
end
