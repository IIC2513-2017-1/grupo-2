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

admin = User.new(username: "admin", email: "admin@admin.admin", password: "administrator", password_confirmation: "administrator")
admin.role = Role.find_by_name("admin")
admin.save

product = Product.create(name: "Poké Ball", description: "Basic poké ball for catching low level and weak pokémon.", price: 200, stock: 150, offer: 0)
product = Product.create(name: "Great Ball", description: "Elaborate poké ball for catching medium leveled pokémon.", price: 600, stock: 90, offer: 0)
product = Product.create(name: "Ultra Ball", description: "Incredible poké ball for catching high level and strong pokémon.", price: 1200, stock: 50, offer: 0)
product = Product.create(name: "Master Ball", description: "Perfect poké ball for catching any pokémon in one try. Recommended for use on legendary or mythical pokémon.", price: 1000000, stock: 1, offer: 0)
