class User < ApplicationRecord
  ROLES = %w[student teacher].freeze

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: ROLES }

  # As a teacher
  has_many :class_sessions, foreign_key: :teacher_id, dependent: :destroy, inverse_of: :teacher

  # As a student
  has_many :enrollments, foreign_key: :student_id, dependent: :destroy, inverse_of: :student
  has_many :class_sessions_as_student, through: :enrollments, source: :class_session

  scope :students, -> { where(role: "student") }
  scope :teachers, -> { where(role: "teacher") }

  def full_name
    "#{first_name} #{last_name}"
  end

  def student?
    role == "student"
  end

  def teacher?
    role == "teacher"
  end
end
