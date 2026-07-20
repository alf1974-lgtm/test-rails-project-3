FactoryBot.define do
  factory :enrollment do
    association :class_session
    association :student, factory: [:user, :student]
    grade { nil }
  end
end
