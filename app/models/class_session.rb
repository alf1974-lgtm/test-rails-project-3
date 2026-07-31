class ClassSession < ApplicationRecord
  belongs_to :course
  belongs_to :semester
  belongs_to :teacher, class_name: "User", foreign_key: :teacher_id

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :student

  validates :course_id,   presence: true
  validates :semester_id, presence: true
  validates :teacher_id,  presence: true
end
