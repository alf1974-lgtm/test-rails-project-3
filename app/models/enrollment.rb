class Enrollment < ApplicationRecord
  GRADES = %w[A A- B+ B B- C+ C C- D+ D D- F W].freeze
  STATUSES = %w[enrolled withdrawn completed].freeze

  belongs_to :student, class_name: "User"
  belongs_to :class_session

  validates :student, :class_session, presence: true
  validates :student_id, uniqueness: { scope: :class_session_id,
                                       message: "is already enrolled in this class session" }
  validates :grade, inclusion: { in: GRADES }, allow_nil: true
  validates :status, inclusion: { in: STATUSES }
  validate :student_must_be_a_student

  private

  def student_must_be_a_student
    return unless student

    errors.add(:student, "must have the student role") unless student.student?
  end
end
