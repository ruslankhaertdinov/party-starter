FactoryGirl.define do
  factory :event do
    owner { build(:user) }
    name { Faker::Lorem.sentence }
  end
end
