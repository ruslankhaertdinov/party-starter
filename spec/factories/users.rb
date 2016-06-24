FactoryGirl.define do
  factory :user do
    email
    password
  end

  trait :with_availability do
    availability do
      { "monday" =>
        [
          { "start_at" => "11", "end_at" => "12" },
          { "start_at" => "15", "end_at" => "17" }
        ]
      }
    end
  end
end
