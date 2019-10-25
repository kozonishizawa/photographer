# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
  name: "admin",
  email: "1@gmail.com",
  tel: "09000000000",
  password: "111111",
  admin: true,
)
User.create!(
  name: "sample",
  email: "2@gmail.com",
  tel: "09000000000",
  password: "222222",
  admin: false,
)