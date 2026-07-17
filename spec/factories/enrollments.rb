FactoryBot.define do
  factory :enrollment do
    association :class_session
    association :student, factory: :student
    grade { nil }

    trait :graded do
      grade { 'A' }
    end

    trait :grade_b do
      grade { 'B' }
    end
  end
end
