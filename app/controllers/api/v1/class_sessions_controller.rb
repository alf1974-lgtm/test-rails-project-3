module Api
  module V1
    class ClassSessionsController < ApplicationController
      def index
        sessions = ClassSession.includes(:course, :semester, :teacher).all
        render json: sessions.map { |cs| class_session_json(cs) }
      end

      def show
        cs = ClassSession.includes(:course, :semester, :teacher, :students).find_by(id: params[:id])
        return render_not_found("ClassSession") unless cs

        render json: class_session_json(cs, include_students: true)
      end

      private

      def class_session_json(cs, include_students: false)
        json = {
          id:       cs.id,
          room:     cs.room,
          schedule: cs.schedule,
          course: {
            id:      cs.course.id,
            name:    cs.course.name,
            code:    cs.course.code,
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

        if include_students
          json[:students] = cs.enrollments.includes(:student).map do |e|
            {
              id:        e.student.id,
              full_name: e.student.full_name,
              email:     e.student.email,
              grade:     e.grade,
              status:    e.status
            }
          end
        end

        json
      end
    end
  end
end
