class User < ApplicationRecord
  enum role: { student: 0, teacher: 1 }

  has_many :enrollments, dependent: :destroy
  has_many :class_sessions_as_teacher, class_name: 'ClassSession', foreign_key: 'teacher_id', dependent: :destroy

  validates :name, :email, :role, presence: true
  validates :email, uniqueness: true
end
