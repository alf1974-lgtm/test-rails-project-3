FactoryBot.define do
  factory :class_session do
    association :course
    association :semester
    association :teacher, factory: [:user, :teacher]
    room     { "Room 101" }
    schedule { "MWF 9:00-9:50" }
  end
end
