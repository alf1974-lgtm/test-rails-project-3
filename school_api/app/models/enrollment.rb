class Enrollment < ApplicationRecord
  belongs_to :class_session
  belongs_to :student, class_name: "User"

  validates :student_id, uniqueness: { scope: :class_session_id,
    message: "is already enrolled in this class session" }
  validates :grade, inclusion: { in: %w[A A- B+ B B- C+ C C- D F], allow_blank: true }
end
