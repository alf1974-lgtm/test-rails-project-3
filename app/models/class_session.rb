class ClassSession < ApplicationRecord
  belongs_to :course
  belongs_to :semester
  belongs_to :teacher, class_name: "User"

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :student

  validates :course_id, presence: true
  validates :semester_id, presence: true
  validates :teacher_id, presence: true

  validate :teacher_must_be_a_teacher

  private

  def teacher_must_be_a_teacher
    return unless teacher
    errors.add(:teacher, "must have the teacher role") unless teacher.teacher?
  end
end
