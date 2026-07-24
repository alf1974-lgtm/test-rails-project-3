FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    role { :student }

    trait :student do
      role { :student }
    end

    trait :teacher do
      role { :teacher }
    end
  end

  factory :department do
    name { Faker::Educator.subject }
  end

  factory :course do
    name { Faker::Educator.course_name }
    code { Faker::Alphanumeric.alphanumeric(number: 6).upcase }
    department
  end

  factory :semester do
    name { ["Fall 2026", "Spring 2027", "Summer 2027"].sample }
  end

  factory :class_session do
    course
    semester
    association :teacher, factory: [:user, :teacher]
  end

  factory :enrollment do
    user
    class_session
    grade { rand(60..100) }
  end
end
