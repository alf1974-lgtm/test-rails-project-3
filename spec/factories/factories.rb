FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "Department #{n}" }
    description { "A department" }
  end

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

  factory :course do
    sequence(:name) { |n| "Course #{n}" }
    sequence(:code) { |n| "CRS#{n.to_s.rjust(3, '0')}" }
    credits { 3 }
    association :department
  end

  factory :semester do
    sequence(:name) { |n| "Semester #{n}" }
    start_date { Date.today }
    end_date   { Date.today + 120 }
  end

  factory :class_session do
    association :course
    association :semester
    association :teacher, factory: [:user, :teacher]
    room     { "Room 101" }
    schedule { "MWF 10:00-10:50" }
  end

  factory :enrollment do
    association :class_session
    association :student, factory: [:user, :student]
    grade { nil }
  end
end
