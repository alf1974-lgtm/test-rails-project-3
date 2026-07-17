class Enrollment < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :class_session

  VALID_GRADES = %w[A A- B+ B B- C+ C C- D+ D D- F].freeze

  validates :student,       presence: true
  validates :class_session, presence: true
  validates :student_id, uniqueness: { scope: :class_session_id,
                                       message: "is already enrolled in this class session" }
  validates :grade, inclusion: { in: VALID_GRADES, allow_nil: true }
  validate  :student_must_have_student_role

  private

  def student_must_have_student_role
    return unless student

    errors.add(:student, "must have the 'student' role") unless student.student?
  end
end
