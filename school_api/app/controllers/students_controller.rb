class StudentsController < ApplicationController
  before_action :set_student

  # GET /students/:id
  # Returns the student's profile information
  def show
    render json: {
      id: @student.id,
      name: @student.name,
      email: @student.email,
      role: @student.role
    }
  end

  # GET /students/:id/class_sessions
  # Returns all class sessions the student is enrolled in,
  # including course, semester, teacher, and grade info
  def class_sessions
    enrollments = @student.enrollments
                          .includes(class_session: [{ course: :department }, :semester, :teacher])

    render json: enrollments.map { |enrollment|
      session = enrollment.class_session
      {
        enrollment_id: enrollment.id,
        grade: enrollment.grade,
        class_session: {
          id: session.id,
          course: {
            id: session.course.id,
            name: session.course.name,
            code: session.course.code,
            description: session.course.description,
            department: {
              id: session.course.department.id,
              name: session.course.department.name
            }
          },
          semester: {
            id: session.semester.id,
            name: session.semester.name,
            season: session.semester.season,
            year: session.semester.year
          },
          teacher: {
            id: session.teacher.id,
            name: session.teacher.name,
            email: session.teacher.email
          }
        }
      }
    }
  end

  private

  def set_student
    @student = User.students.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Student not found" }, status: :not_found
  end
end
