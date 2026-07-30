class User < ApplicationRecord
  ROLES = %w[student teacher].freeze

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role,  inclusion: { in: ROLES }

  # As a teacher: the class sessions they teach
  has_many :taught_sessions, class_name: "ClassSession", foreign_key: :teacher_id, dependent: :nullify

  # As a student: enrollments and the class sessions through them
  has_many :enrollments,     foreign_key: :student_id, dependent: :destroy
  has_many :enrolled_sessions, through: :enrollments, source: :class_session, class_name: "ClassSession"

  scope :students, -> { where(role: "student") }
  scope :teachers, -> { where(role: "teacher") }

  def student? = role == "student"
  def teacher? = role == "teacher"
end
