FactoryGirl.define do
  factory :user do
    email
    password
    uuid { SecureRandom.uuid }
  end
end
