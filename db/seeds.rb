# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(email: 'test@test.com', password: 'azertyuiop', password_confirmation: 'azertyuiop', superadmin_role: true, author_role: true)
Game.create(name: "lol", logo_url: "assets/LOL_logo.png")