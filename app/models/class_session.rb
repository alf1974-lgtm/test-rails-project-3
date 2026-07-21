class ClassSession < ApplicationRecord
  belongs_to :course
  belongs_to :semester
  belongs_to :teacher, class_name: "User", inverse_of: :taught_sessions

  has_many :enrollments,  dependent: :destroy
  has_many :students,     through: :enrollments, source: :student

  validates :teacher, presence: true
  validate  :teacher_must_have_teacher_role

  private

  def teacher_must_have_teacher_role
    return unless teacher
    errors.add(:teacher, "must have the 'teacher' role") unless teacher.teacher?
  end
end
