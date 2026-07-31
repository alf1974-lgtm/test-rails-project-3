class User < ApplicationRecord
  ROLES = %w[student teacher].freeze

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,      presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role,       inclusion: { in: ROLES }

  # As a teacher
  has_many :taught_sessions, class_name: "ClassSession", foreign_key: :teacher_id, dependent: :nullify

  # As a student
  has_many :enrollments,     foreign_key: :student_id, dependent: :destroy
  has_many :class_sessions,  through: :enrollments

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
