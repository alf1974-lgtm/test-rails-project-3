class User < ApplicationRecord
  ROLES = %w[student teacher].freeze

  # Associations
  has_many :enrollments, foreign_key: :student_id, dependent: :destroy
  has_many :class_sessions_as_student,
           through: :enrollments,
           source: :class_session

  has_many :class_sessions_as_teacher,
           class_name: "ClassSession",
           foreign_key: :teacher_id,
           dependent: :nullify

  # Validations
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,      presence: true, uniqueness: { case_sensitive: false },
                         format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role,       inclusion: { in: ROLES }

  # Scopes
  scope :students, -> { where(role: "student") }
  scope :teachers, -> { where(role: "teacher") }

  # Helpers
  def student? = role == "student"
  def teacher? = role == "teacher"

  def full_name
    "#{first_name} #{last_name}"
  end
end
