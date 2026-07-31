class ClassSession < ApplicationRecord
  validates :course,   presence: true
  validates :semester, presence: true
  validates :teacher,  presence: true
  validate  :teacher_must_be_teacher

  belongs_to :course
  belongs_to :semester
  belongs_to :teacher, class_name: "User"

  has_many :enrollments,  dependent: :destroy
  has_many :students,     through: :enrollments, source: :student

  private

  def teacher_must_be_teacher
    if teacher.present? && !teacher.teacher?
      errors.add(:teacher, "must have role 'teacher'")
    end
  end
end
