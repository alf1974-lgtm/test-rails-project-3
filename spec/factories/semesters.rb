FactoryBot.define do
  factory :semester do
    sequence(:name) { |n| "Semester #{n}" }
    start_date { Date.today }
    end_date   { Date.today + 120 }
  end
end
