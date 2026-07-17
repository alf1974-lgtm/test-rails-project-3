class ClassSession < ApplicationRecord
  MAX_STUDENTS = 18

  belongs_to :course
  belongs_to :semester
  belongs_to :teacher, class_name: 'User', inverse_of: :taught_sessions

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :student

  validates :course_id, uniqueness: { scope: %i[semester_id teacher_id],
                                      message: 'already has a session for this course, semester, and teacher' }
  validate :teacher_must_be_a_teacher
  validate :enrollment_cap

  def full?
    enrollments.size >= MAX_STUDENTS
  end

  private

  def teacher_must_be_a_teacher
    return if teacher.nil?
    return if teacher.teacher?

    errors.add(:teacher, 'must have the teacher role')
  end

  def enrollment_cap
    return unless enrollments.size > MAX_STUDENTS

    errors.add(:base, "class session cannot exceed #{MAX_STUDENTS} students")
  end
end
