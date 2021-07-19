FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    name { Faker::Name.name }
    introduction { Faker::Lorem.characters(number: 20) }
  end
end
