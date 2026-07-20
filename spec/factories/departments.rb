FactoryBot.define do
  factory :department do
    sequence(:name) { |n| "Department #{n}" }
    description { "A department" }
  end
end
