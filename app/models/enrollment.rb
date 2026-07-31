class Enrollment < ApplicationRecord
  belongs_to :class_session
  belongs_to :student, class_name: "User"

  VALID_GRADES = %w[A A- B+ B B- C+ C C- D+ D D- F W IP].freeze
  STATUS_OPTIONS = %w[enrolled dropped completed].freeze

  validates :class_session_id, presence: true
  validates :student_id, presence: true
  validates :student_id, uniqueness: { scope: :class_session_id, message: "is already enrolled in this class session" }
  validates :grade, inclusion: { in: VALID_GRADES, allow_blank: true }
  validates :status, inclusion: { in: STATUS_OPTIONS }

  validate :student_must_be_a_student

  private

  def student_must_be_a_student
    return unless student
    errors.add(:student, "must have the student role") unless student.student?
  end
end
