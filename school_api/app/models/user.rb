class User < ApplicationRecord
  ROLES = %w[student teacher].freeze

  has_many :enrollments, foreign_key: :student_id, dependent: :destroy
  has_many :class_sessions_as_student, through: :enrollments, source: :class_session
  has_many :class_sessions_as_teacher, class_name: "ClassSession", foreign_key: :teacher_id, dependent: :nullify

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: ROLES }

  scope :students, -> { where(role: "student") }
  scope :teachers, -> { where(role: "teacher") }

  def student?
    role == "student"
  end

  def teacher?
    role == "teacher"
  end
end
