FactoryBot.define do
  factory :course do
    sequence(:name)        { |n| "Course #{n}" }
    sequence(:course_code) { |n| "CS#{100 + n}" }
    credits { 3 }
    description { "A course" }
    association :department
  end
end
