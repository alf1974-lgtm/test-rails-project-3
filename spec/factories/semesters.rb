FactoryBot.define do
  factory :semester do
    sequence(:name) { |n| "Fall #{2020 + n}" }
    season { 'Fall' }
    sequence(:year) { |n| 2020 + n }

    trait :fall do
      season { 'Fall' }
    end

    trait :spring do
      season { 'Spring' }
      sequence(:name) { |n| "Spring #{2020 + n}" }
    end
  end
end
