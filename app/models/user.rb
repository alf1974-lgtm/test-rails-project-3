class User < ApplicationRecord
  ROLES = %w[student teacher].freeze
  GRADES = [9, 10, 11, 12].freeze
  LETTER_GRADES = %w[A B C D F].freeze

  # Self-referential advisor relationship
  belongs_to :advisor, class_name: 'User', optional: true

  has_many :advisees, class_name: 'User', foreign_key: :advisor_id, dependent: :nullify, inverse_of: :advisor

  # Teacher associations
  has_many :taught_sessions, class_name: 'ClassSession', foreign_key: :teacher_id,
                             dependent: :destroy, inverse_of: :teacher

  # Student associations (through Enrollment join model)
  has_many :enrollments, foreign_key: :student_id, dependent: :destroy, inverse_of: :student
  has_many :class_sessions, through: :enrollments

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: 'must be a valid email address' }
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :grade, inclusion: { in: GRADES, allow_nil: true },
                    numericality: { only_integer: true, allow_nil: true }
  validate :grade_only_for_students
  validate :advisor_must_be_teacher

  def full_name
    "#{first_name} #{last_name}"
  end

  def student?
    role == 'student'
  end

  def teacher?
    role == 'teacher'
  end

  private

  def grade_only_for_students
    return if student?
    return if grade.nil?

    errors.add(:grade, 'can only be set for students')
  end

  def advisor_must_be_teacher
    return if advisor.nil?
    return if advisor.teacher?

    errors.add(:advisor, 'must be a teacher')
  end
end
