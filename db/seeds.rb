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
  activated: true,
  activated_at: Time.zone.now
)
User.create!(
  name: "sample",
  email: "2@gmail.com",
  tel: "09000000000",
  password: "222222",
  admin: false,
  activated: true,
  activated_at: Time.zone.now
)
ContactStatus.create!(
  name: STATUS_NOT_YET,
  description: '未対応です',
  position: 1
)
ContactStatus.create!(
  name: STATUS_DONE,
  description: '完了しています',
  position: 2
)