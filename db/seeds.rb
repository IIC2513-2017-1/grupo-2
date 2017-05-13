# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['user', 'admin'].each do |role|
  Role.find_or_create_by({name: role})
end

Cart.destroy_all
User.destroy_all
Product.destroy_all

admin = User.new(username: "admin", email: "admin@admin.admin", password: "administrator", password_confirmation: "administrator")
admin.role = Role.find_by_name("admin")
admin.save


# Users
30.times do
  username = Faker::Internet.unique.user_name
  email = Faker::Internet.email(username)
  password = Faker::Internet.password(8)
  User.create(username: username, email: email, password: password, password_confirmation: password)
end

# Categories
8.times do
  Category.create(name: Faker::Commerce.unique.department(1))
end

# Products
50.times do
  name = Faker::Commerce.unique.product_name
  description = Faker::Lorem.paragraph
  price = Integer Faker::Commerce.price
  stock = Faker::Number.between(0, 1000)
  offer = Faker::Number.between(0, 100)

  p = Product.create(name: name, description: description, price: price, stock: stock, offer: offer)
  p.categories << Category.order('RANDOM()').limit(1 + rand(8))  # assign categories

  # Create comments for the product
  rand(3).times do
    Comment.create(
      content: Faker::Lorem.paragraph,
      product: p,
      user: User.order('RANDOM()').first)
  end
end
