class ClassSession < ApplicationRecord
  belongs_to :course
  belongs_to :semester
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  validates :course_id, :semester_id, :teacher_id, presence: true
  validate :teacher_must_be_teacher

  private

  def teacher_must_be_teacher
    if teacher && !teacher.teacher?
      errors.add(:teacher_id, "must be a teacher")
    end
  end
end
