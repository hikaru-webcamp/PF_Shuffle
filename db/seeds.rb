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

10.times do |n|
  User.create!(
    name: "太郎#{n}",
    introduction: "宜しくお願いします",
    email: "user#{n}@test.com",
    password: "testtest",
    profile_image: File.open("#{Rails.root}/app/assets/images/groupimage#{n}.jpeg")
  )
end

10.times do |n|
  Group.create!(
    name: "チーム#{n}",
    introduction: "楽しいチーム#{n}",
    owner_id: User.find(n+1).id,
    image: File.open("#{Rails.root}/app/assets/images/groupimage#{n}.jpeg")
  )
  end