class User < ApplicationRecord
  ROLES = %w[student teacher].freeze

  has_many :enrollments, foreign_key: :student_id, dependent: :destroy
  has_many :class_sessions_as_student,
           through: :enrollments,
           source: :class_session

  has_many :class_sessions_as_teacher,
           class_name: "ClassSession",
           foreign_key: :teacher_id,
           dependent: :nullify

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :student_id, uniqueness: true, allow_nil: true
  validates :employee_id, uniqueness: true, allow_nil: true

  scope :students, -> { where(role: "student") }
  scope :teachers, -> { where(role: "teacher") }

  def student?
    role == "student"
  end

  def teacher?
    role == "teacher"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def to_s
    full_name
  end
end
