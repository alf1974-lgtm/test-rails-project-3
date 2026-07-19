class User < ApplicationRecord
  ROLES = %w[student teacher].freeze

  has_many :enrollments, foreign_key: :student_id, dependent: :destroy
  has_many :class_sessions_as_student, through: :enrollments, source: :class_session
  has_many :class_sessions_as_teacher, class_name: "ClassSession", foreign_key: :teacher_id, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :email,      presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role,       inclusion: { in: ROLES }

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
