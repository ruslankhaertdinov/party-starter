FactoryGirl.define do
  factory :availability do
    event
    user
  end

  trait :with_intervals do
    intervals {{ tuesday: [{ start_at: "9", end_at: "10" }, { start_at: "18", end_at: "19" }] }}
  end
end
