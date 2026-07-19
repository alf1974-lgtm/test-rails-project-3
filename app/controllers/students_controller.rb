class StudentsController < ApplicationController
  before_action :set_student

  # GET /students/:id
  # Returns the student's basic info
  def show
    render json: {
      id:    @student.id,
      name:  @student.name,
      email: @student.email,
      role:  @student.role
    }
  end

  # GET /students/:id/courses
  # Returns all class sessions the student is enrolled in,
  # grouped with course, department, semester, teacher, and grade info
  def courses
    enrollments = @student.enrollments
                          .includes(class_session: [ :course, :semester, :teacher, { course: :department } ])

    data = enrollments.map do |enrollment|
      session    = enrollment.class_session
      course     = session.course
      department = course.department
      semester   = session.semester
      teacher    = session.teacher

      {
        enrollment_id:   enrollment.id,
        grade:           enrollment.grade,
        class_session_id: session.id,
        semester: {
          id:   semester.id,
          name: semester.name
        },
        course: {
          id:         course.id,
          name:       course.name,
          department: {
            id:   department.id,
            name: department.name
          }
        },
        teacher: {
          id:   teacher.id,
          name: teacher.name
        }
      }
    end

    render json: {
      student: {
        id:    @student.id,
        name:  @student.name,
        email: @student.email
      },
      courses: data
    }
  end

  private

  def set_student
    @student = User.find(params[:id])
    unless @student.student?
      render json: { error: "User is not a student" }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Student not found" }, status: :not_found
  end
end
