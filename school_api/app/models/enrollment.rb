class Enrollment < ApplicationRecord
  belongs_to :class_session
  belongs_to :student, class_name: "User"

  validates :student_id, uniqueness: { scope: :class_session_id, message: "is already enrolled in this class session" }
end
