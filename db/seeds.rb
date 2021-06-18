# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
Faker::Config.locale = :ja

Admin.create!(
   [
    {name: "HIKARU", email: "admin1@test.com", password: "testtest", introduction: "よろしくおねがいします", profile_image: File.open('./app/assets/images/admin_profil_HIKARU.jpg') },
    {name: "MUKKU", email: "admin2@test.com", password: "testtest", introduction: "よろしくおねがいします", profile_image: File.open('./app/assets/images/admin_profil_MUKKU.jpg') }, 
    {name: "DARUMI", email: "admin3@test.com", password: "testtest", introduction: "よろしくおねがいします", profile_image: File.open('./app/assets/images/admin_profil_DARUMI.jpg') }
   ]
 )

User.create!(
  name: "テストアカウント",
  introduction: "宜しくお願いします",
  email: "user1@test.com",
  password: "testtest",
  profile_image: File.open("./app/assets/images/admin_profil_HIKARU.jpg")
)

75.times do |n|
  User.create!(
    name: Faker::Name.name ,
    introduction: "はじめまして、よろしくお願いします!", 
    email: Faker::Internet.email,
    password: "testtest",
    profile_image: File.open("#{Rails.root}/app/assets/images/user_sample_image/user_sample_image#{n}.jpg")
  )
end

75.times do |n|
  Group.create!(
    name:  Faker::Artist.name,
    introduction: "最高に楽しいチームです！",
    owner_id: User.find(n+1).id,
    image: File.open("#{Rails.root}/app/assets/images/group_sample_image/group_sample_image#{n}.jpg")
  )
end

50.times do |n|
  Post.create!(
    title: "#{n + 1}月生によるイベント会",
    body: Faker::Lorem.unique.paragraph, 
    user_id: User.find(n+1).id,
    group_id: Group.find(n+1).id
  )
end

15.times do |n|
  GroupUser.create!(
    user_id: User.find(n+1).id,
    group_id: Group.find(n+1).id
  )
end