class ClassSession < ApplicationRecord
  belongs_to :course
  belongs_to :semester
  belongs_to :teacher, class_name: "User"

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :student

  validates :course,   presence: true
  validates :semester, presence: true
  validates :teacher,  presence: true
  validate  :teacher_must_have_teacher_role

  private

  def teacher_must_have_teacher_role
    errors.add(:teacher, "must have the teacher role") if teacher && !teacher.teacher?
  end
end
