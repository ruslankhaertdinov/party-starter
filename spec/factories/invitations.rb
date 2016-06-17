FactoryGirl.define do
  factory :invitation do
    user
    event
    token { SecureRandom.base64 }
  end
end
