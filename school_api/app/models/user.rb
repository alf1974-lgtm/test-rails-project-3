class User < ApplicationRecord
  # role can be "student" or "teacher"
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[student teacher] }

  has_many :taught_sessions, class_name: "ClassSession", foreign_key: :teacher_id, dependent: :destroy
  has_many :enrollments, foreign_key: :student_id, dependent: :destroy
  has_many :class_sessions, through: :enrollments

  scope :students, -> { where(role: "student") }
  scope :teachers, -> { where(role: "teacher") }
end
