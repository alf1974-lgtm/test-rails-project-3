class Enrollment < ApplicationRecord
  VALID_GRADES = %w[A B C D F].freeze

  belongs_to :class_session
  belongs_to :student, class_name: 'User', inverse_of: :enrollments

  validates :class_session_id, uniqueness: { scope: :student_id,
                                             message: 'student is already enrolled in this class session' }
  validates :grade, inclusion: { in: VALID_GRADES, allow_nil: true,
                                 message: 'must be A, B, C, D, or F' }
  validate :student_must_be_a_student

  private

  def student_must_be_a_student
    return if student.nil?
    return if student.student?

    errors.add(:student, 'must have the student role')
  end
end
