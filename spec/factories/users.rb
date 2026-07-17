FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| "First#{n}" }
    sequence(:last_name)  { |n| "Last#{n}" }
    sequence(:email)      { |n| "user#{n}@example.com" }
    role { 'student' }
    grade { 9 }
    advisor { nil }

    trait :student do
      role  { 'student' }
      grade { 9 }
    end

    trait :teacher do
      role  { 'teacher' }
      grade { nil }
    end

    trait :with_advisor do
      association :advisor, factory: %i[user teacher]
    end

    factory :student, traits: [:student]
    factory :teacher, traits: [:teacher]
  end
end
