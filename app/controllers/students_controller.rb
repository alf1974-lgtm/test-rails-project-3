class StudentsController < ApplicationController
  before_action :set_student

  # GET /students/:id
  # Returns the student's basic profile info.
  def show
    render json: student_json(@student)
  end

  # GET /students/:id/courses
  # Returns all class sessions the student is enrolled in,
  # across all semesters, with grade info.
  def courses
    enrollments = @student.enrollments
                          .includes(class_session: [:course, :semester, :teacher])
                          .joins(class_session: [:semester, :course])
                          .order("semesters.name, courses.name")

    render json: enrollments.map { |e| enrollment_json(e) }
  end

  private

  def set_student
    @student = User.students.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Student not found" }, status: :not_found
  end

  def student_json(user)
    {
      id:    user.id,
      name:  user.name,
      email: user.email,
      role:  user.role
    }
  end

  def enrollment_json(enrollment)
    cs       = enrollment.class_session
    course   = cs.course
    semester = cs.semester
    teacher  = cs.teacher

    {
      enrollment_id: enrollment.id,
      grade:         enrollment.grade,
      semester: {
        id:   semester.id,
        name: semester.name
      },
      course: {
        id:          course.id,
        name:        course.name,
        code:        course.code,
        description: course.description,
        department:  course.department.name
      },
      class_session: {
        id:       cs.id,
        room:     cs.room,
        schedule: cs.schedule
      },
      teacher: {
        id:   teacher.id,
        name: teacher.name
      }
    }
  end
end
