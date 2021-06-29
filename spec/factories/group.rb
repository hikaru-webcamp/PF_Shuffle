FactoryBot.define do
  factory :group do
    group_id { FactoryBot.create(:group).id }
    name { Faker::Artist.name }
    introduction { Faker::Lorem.characters(number: 20) }
    owner_id { FactoryBot.create(:user).id }
  end
end