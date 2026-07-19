class StudentsController < ApplicationController
  before_action :set_student

  # GET /students/:id
  def show
    render json: student_json(@student)
  end

  # GET /students/:id/courses
  def courses
    enrollments = @student.enrollments
                          .includes(class_session: [ :course, :semester, :teacher ])
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
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role
    }
  end

  def enrollment_json(enrollment)
    cs = enrollment.class_session
    {
      enrollment_id: enrollment.id,
      grade: enrollment.grade,
      class_session: {
        id: cs.id,
        course: {
          id: cs.course.id,
          name: cs.course.name,
          code: cs.course.code,
          department: cs.course.department&.name
        },
        semester: {
          id: cs.semester.id,
          name: cs.semester.name
        },
        teacher: {
          id: cs.teacher.id,
          name: cs.teacher.name,
          email: cs.teacher.email
        }
      }
    }
  end
end
