class Enrollment < ApplicationRecord
  belongs_to :class_session
  belongs_to :student, class_name: "User"

  validates :class_session, presence: true
  validates :student,       presence: true
  validates :student_id,    uniqueness: { scope: :class_session_id,
                                          message: "is already enrolled in this class session" }
  validate  :student_must_be_student_role

  VALID_GRADES = %w[A A- B+ B B- C+ C C- D+ D D- F].freeze

  validates :grade, inclusion: { in: VALID_GRADES, allow_nil: true }

  private

  def student_must_be_student_role
    return unless student
    errors.add(:student, "must have role 'student'") unless student.student?
  end
end
