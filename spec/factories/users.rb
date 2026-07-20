FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "First#{n}" }
    sequence(:last_name)  { |n| "Last#{n}" }
    sequence(:email)      { |n| "user#{n}@example.com" }
    role { "student" }

    trait :student do
      role { "student" }
    end

    trait :teacher do
      role { "teacher" }
    end
  end
end
