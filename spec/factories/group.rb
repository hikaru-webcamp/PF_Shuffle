FactoryBot.define do
  factory :group do
    name { Faker::Name.name }
    introduction { Faker::Lorem.characters(number: 20) }
  end
end
