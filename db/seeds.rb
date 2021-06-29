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
    {name: "KAJI", email: "admin3@test.com", password: "testtest", introduction: "よろしくおねがいします", profile_image: File.open('./app/assets/images/admin_profil_KAJI.jpg') },
    {name: "RIKO", email: "admin4@test.com", password: "testtest", introduction: "よろしくおねがいします", profile_image: File.open('./app/assets/images/admin_profil_RIKO.jpg') },
    {name: "TOMA", email: "admin5@test.com", password: "testtest", introduction: "よろしくおねがいします", profile_image: File.open('./app/assets/images/admin_profil_TOMA.jpg') },
    {name: "KASUMI", email: "admin6@test.com", password: "testtest", introduction: "よろしくおねがいします", profile_image: File.open('./app/assets/images/admin_profil_KASUMI.jpg') }
   ]
 )

User.create!(
  name: "テストアカウント",
  introduction: "宜しくお願いします",
  email: "user1@test.com",
  password: "testtest",
  profile_image: File.open("./app/assets/images/testimage.jpg")
)


if Rails.env.production?
  RAND_FUNC = 'RAND()'
else
  RAND_FUNC = 'RANDOM()'
end

75.times do |n|
  User.create!(
    name: Faker::Name.name ,
    introduction: "はじめまして、よろしくお願いします!", 
    email: Faker::Internet.unique.email,
    password: "testtest",
    profile_image: File.open("#{Rails.root}/app/assets/images/user_sample_image/user_sample_image#{n}.jpg")
  )
end

75.times do |n|
  group = Group.create!(
    name:  Faker::Games::Witcher.unique.character,
    introduction: "最高に楽しいチームです！",
    owner_id: User.find(n+1).id,
    image: File.open("#{Rails.root}/app/assets/images/group_sample_image/group_sample_image#{n}.jpg")
  )
  
  post = Post.create!(
    title: "#{n + 1}月生によるイベント会",
    body: Faker::Lorem.unique.paragraph, 
    user_id: User.find(n+1).id,
    group_id: Group.find(n+1).id,
    youtube_url: "https://www.youtube.com/watch?v=Xsd6VgbyJeI"
  )
  
  users = User.order(RAND_FUNC).limit(rand(1..10))
  users.each do |user|
    GroupUser.create!(user_id: user.id, group_id: group.id)
    Post.create!(user_id: user.id, group_id: group.id, title: "#{n + 1}月生によるイベント会", body: Faker::Lorem.unique.paragraph)
  end
  
  
  users = User.order(RAND_FUNC).limit(rand(1..10))
  users.each do |user|
    Like.create!(user_id: user.id, post_id: post.id)
    Comment.create!(user_id: user.id, post_id: post.id, body: Faker::Lorem.unique.paragraph)
  end
  
end

