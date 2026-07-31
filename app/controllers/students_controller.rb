class StudentsController < ApplicationController
  before_action :set_student

  # GET /students/:id
  # Returns the student's basic info
  def show
    render json: {
      id:         @student.id,
      first_name: @student.first_name,
      last_name:  @student.last_name,
      full_name:  @student.full_name,
      email:      @student.email,
      role:       @student.role
    }
  end

  # GET /students/:id/courses
  # Returns all class sessions (with course, semester, teacher, and grade) for the student
  def courses
    enrollments = @student.enrollments
                          .includes(class_session: [:course, :semester, :teacher])
                          .order("semesters.name, courses.name")

    render json: enrollments.map { |e|
      cs = e.class_session
      {
        enrollment_id:     e.id,
        grade:             e.grade,
        class_session_id:  cs.id,
        room:              cs.room,
        schedule:          cs.schedule,
        course: {
          id:          cs.course.id,
          name:        cs.course.name,
          code:        cs.course.code,
          description: cs.course.description,
          department:  cs.course.department.name
        },
        semester: {
          id:         cs.semester.id,
          name:       cs.semester.name,
          start_date: cs.semester.start_date,
          end_date:   cs.semester.end_date
        },
        teacher: {
          id:        cs.teacher.id,
          full_name: cs.teacher.full_name,
          email:     cs.teacher.email
        }
      }
    }
  end

  private

  def set_student
    @student = User.students.find_by(id: params[:id])
    render_not_found("Student") unless @student
  end
end
