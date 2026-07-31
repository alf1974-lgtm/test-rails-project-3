class User < ApplicationRecord
  ROLES = %w[student teacher].freeze

  validates :name,  presence: true
  validates :email, presence: true, uniqueness: true
  validates :role,  inclusion: { in: ROLES }

  # As a teacher
  has_many :taught_sessions, class_name: "ClassSession", foreign_key: :teacher_id, dependent: :destroy

  # As a student
  has_many :enrollments, foreign_key: :student_id, dependent: :destroy
  has_many :class_sessions, through: :enrollments

  scope :students, -> { where(role: "student") }
  scope :teachers, -> { where(role: "teacher") }

  def student? = role == "student"
  def teacher? = role == "teacher"
end
