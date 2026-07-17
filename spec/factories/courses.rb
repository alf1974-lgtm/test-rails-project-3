FactoryBot.define do
  factory :course do
    sequence(:name) { |n| "Course #{n}" }
    sequence(:code) { |n| "CRS#{(100 + n).to_s.rjust(3, '0')}" }
    association :department
  end
end
