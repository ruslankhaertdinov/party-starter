FactoryGirl.define do
  factory :availability do
    user
    start_at { 10.minutes.from_now }
    end_at { 15.minutes.from_now }
  end
end
