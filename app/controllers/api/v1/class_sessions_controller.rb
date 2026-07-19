module Api
  module V1
    class ClassSessionsController < ApplicationController
      def index
        sessions = ClassSession.includes(:course, :semester, :teacher)
                               .order("semesters.start_date DESC, courses.code ASC")
        render json: sessions.map { |cs| class_session_json(cs) }
      end

      def show
        session = ClassSession.includes(:course, :semester, :teacher, :students).find(params[:id])
        render json: class_session_json(session, include_students: true)
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
          json[:enrollments] = cs.enrollments.map do |e|
            {
              student_id: e.student_id,
              full_name:  e.student.full_name,
              grade:      e.grade
            }
          end
        end

        json
      end
    end
  end
end
