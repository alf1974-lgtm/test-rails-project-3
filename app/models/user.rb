class User < ApplicationRecord
  # role: "student" or "teacher"
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[student teacher] }

  # As a teacher
  has_many :taught_sessions, class_name: "ClassSession", foreign_key: :teacher_id, dependent: :destroy

  # As a student
  has_many :enrollments, foreign_key: :student_id, dependent: :destroy
  has_many :class_sessions, through: :enrollments

  def student?
    role == "student"
  end

  def teacher?
    role == "teacher"
  end
end
