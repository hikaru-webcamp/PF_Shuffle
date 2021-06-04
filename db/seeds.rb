# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@gmail.com',
  password: 'testtest'
)

5.times do |n|
  User.create!(
    name: "太郎#{n}",
    email: "user#{n}@test.com",
    password: "testtest"
  )
end

10.times do |n|
  Group.create!(
    name: "チーム#{n}",
    introduction: "楽しい#{n}",
    title: "朝活#{n}",
    body: "ok",
    image: File.open("#{Rails.root}/app/assets/images/test_image.jpg")
  )
end