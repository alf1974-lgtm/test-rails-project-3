class ClassSessionsController < ApplicationController
  def index
    sessions = ClassSession.includes(:course, :semester, :teacher).order("semesters.name, courses.name")
    render json: sessions.map { |cs| serialize_session(cs) }
  end

  def show
    cs = ClassSession.includes(:course, :semester, :teacher, :students).find_by(id: params[:id])
    return render_not_found("ClassSession") unless cs

    render json: serialize_session(cs).merge(
      students: cs.students.map { |s|
        enrollment = cs.enrollments.find { |e| e.student_id == s.id }
        { id: s.id, full_name: s.full_name, email: s.email, grade: enrollment&.grade }
      }
    )
  end

  private

  def serialize_session(cs)
    {
      id:       cs.id,
      room:     cs.room,
      schedule: cs.schedule,
      course:   { id: cs.course.id, name: cs.course.name, code: cs.course.code },
      semester: { id: cs.semester.id, name: cs.semester.name },
      teacher:  { id: cs.teacher.id, full_name: cs.teacher.full_name }
    }
  end
end
