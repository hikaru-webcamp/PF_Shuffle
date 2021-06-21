FactoryBot.define do
  factory :group do
    group_id { 1 }
    name { Faker::Artist.name }
    image_id { Faker::Lorem.characters(number:10) }
    introduction { Faker::Lorem.characters(number: 20) }
    owner_id { 1 }
  end
end