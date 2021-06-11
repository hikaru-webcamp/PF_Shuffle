# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Admin.create!(
  email: 'admin@gmail.com',
  password: 'testtest'
)

15.times do |n|
  User.create!(
    name: Faker::Name.name ,
    introduction: "宜しくお願いします",
    email: Faker::Internet.email,
    password: "testtest",
    profile_image: File.open("#{Rails.root}/app/assets/images/groupimage#{n}.jpeg")
  )
end

15.times do |n|
  Group.create!(
    name: "チーム#{n}",
    introduction: "楽しいチーム#{n}",
    owner_id: User.find(n+1).id,
    image: File.open("#{Rails.root}/app/assets/images/groupimage#{n}.jpeg")
  )
end

15.times do |n|
  Post.create!(
    title: "#{n}月生",
    body: "#{n}月生の会をやります",
    user_id: User.find(n+1).id,
    group_id: Group.find(n+1).id,
  )
end