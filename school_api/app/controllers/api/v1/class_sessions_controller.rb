module Api
  module V1
    class ClassSessionsController < ApplicationController
      def index
        sessions = ClassSession.includes(:course, :semester, :teacher)
                               .order("semesters.start_date DESC, courses.code ASC")
        render json: sessions.map { |cs| class_session_json(cs) }
      end

      def show
        cs = ClassSession.includes(:course, :semester, :teacher, :students).find(params[:id])
        render json: class_session_json(cs).merge(
          students: cs.students.map { |s|
            enrollment = cs.enrollments.find { |e| e.student_id == s.id }
            { id: s.id, full_name: s.full_name, email: s.email, grade: enrollment&.grade }
          }
        )
      end

      private

      def class_session_json(cs)
        {
          id:       cs.id,
          room:     cs.room,
          schedule: cs.schedule,
          course: {
            id:      cs.course.id,
            code:    cs.course.code,
            name:    cs.course.name,
            credits: cs.course.credits
          },
          semester: {
            id:   cs.semester.id,
            name: cs.semester.name
          },
          teacher: {
            id:        cs.teacher.id,
            full_name: cs.teacher.full_name,
            email:     cs.teacher.email
          }
        }
      end
    end
  end
end
