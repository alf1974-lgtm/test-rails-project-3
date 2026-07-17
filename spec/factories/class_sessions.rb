FactoryBot.define do
  factory :class_session do
    association :course
    association :semester
    association :teacher, factory: :teacher
  end
end
