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

Comment.destroy_all
User.destroy_all
Product.destroy_all
Category.destroy_all

admin = User.new(username: "admin", email: "amazing.noreply@gmail.com", password: "administrator", password_confirmation: "administrator", email_confirmed: true)
admin.role = Role.find_by_name("admin")
admin.avatar = open(Faker::Avatar.image)
admin.save
admin.generate_token_and_save

# Users
10.times do
  username = Faker::Internet.unique.user_name
  email = Faker::Internet.email(username)
  password = Faker::Internet.password(8)
  avatar = open(Faker::Avatar.image)
  u = User.create(username: username, email: email, password: password, password_confirmation: password, avatar: avatar)
  u.generate_token_and_save
end

# Categories
8.times do
  Category.create(name: Faker::Commerce.unique.department(1))
end

# Products
10.times do
  name = Faker::Commerce.unique.product_name
  description = Faker::Lorem.paragraph
  price = Integer Faker::Commerce.price
  stock = Faker::Number.between(0, 1000)
  offer = Faker::Number.between(0, 100)
  image = open(Faker::Avatar.image)

  p = Product.create(name: name, description: description, price: price, stock: stock, offer: offer, image: image)
  p.categories << Category.order('RANDOM()').limit(1 + rand(8))  # assign categories

  # Create comments for the product
  rand(3).times do
    Comment.create(
      content: Faker::Lorem.paragraph,
      product: p,
      user: User.order('RANDOM()').first)
  end
end

20.times do
  user = User.order('RANDOM()').first
  purchase = Purchase.create(user: user, payment_confirmed: true)
  purchase.update(created_at: purchase.created_at - rand(12).months)

  products = Product.order('RANDOM()')
  for i in 0..Faker::Number.between(1, 5) do
    PurchaseProduct.create(
      purchase: purchase,
      product: products[i],
      amount: Faker::Number.between(1, 30)
    )
  end
end

# product = Product.create(name: "Poké Ball", description: "Basic poké ball for catching low level and weak pokémon.", price: 200, stock: 150, offer: 0)
# product = Product.create(name: "Great Ball", description: "Elaborate poké ball for catching medium leveled pokémon.", price: 600, stock: 90, offer: 0)
# product = Product.create(name: "Ultra Ball", description: "Incredible poké ball for catching high level and strong pokémon.", price: 1200, stock: 50, offer: 0)
# product = Product.create(name: "Master Ball", description: "Perfect poké ball for catching any pokémon in one try. Recommended for use on legendary or mythical pokémon.", price: 1000000, stock: 1, offer: 0)
