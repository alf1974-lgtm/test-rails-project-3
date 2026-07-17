class ClassSession < ApplicationRecord
  validates :course, presence: true
  validates :semester, presence: true
  validates :teacher, presence: true
  validate :teacher_must_have_teacher_role

  belongs_to :course
  belongs_to :semester
  belongs_to :teacher, class_name: "User", foreign_key: :teacher_id, inverse_of: :class_sessions

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :student

  private

  def teacher_must_have_teacher_role
    return unless teacher

    errors.add(:teacher, "must have the teacher role") unless teacher.teacher?
  end
end
