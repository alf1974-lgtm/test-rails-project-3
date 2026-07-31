class ClassSession < ApplicationRecord
  belongs_to :course
  belongs_to :semester
  belongs_to :teacher, class_name: "User"

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :student

  validates :course, :semester, :teacher, presence: true
  validates :max_enrollment, numericality: { greater_than: 0 }, allow_nil: true
  validate :teacher_must_be_a_teacher

  def full_name
    "#{course.code} - #{semester.name}"
  end

  def to_s
    full_name
  end

  private

  def teacher_must_be_a_teacher
    return unless teacher

    errors.add(:teacher, "must have the teacher role") unless teacher.teacher?
  end
end
