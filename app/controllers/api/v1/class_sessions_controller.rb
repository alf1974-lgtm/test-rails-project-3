module Api
  module V1
    class ClassSessionsController < ApplicationController
      before_action :set_class_session, only: [:show, :update, :destroy, :roster, :enroll, :update_grade]

      # GET /api/v1/class_sessions
      def index
        sessions = ClassSession.includes(:course, :semester, :teacher).order(:id)
        render json: sessions.as_json(include: [:course, :semester, :teacher])
      end

      # GET /api/v1/class_sessions/:id
      def show
        render json: @class_session.as_json(include: [:course, :semester, :teacher])
      end

      # POST /api/v1/class_sessions
      def create
        cs = ClassSession.create!(class_session_params)
        render json: cs, status: :created
      end

      # PATCH /api/v1/class_sessions/:id
      def update
        @class_session.update!(class_session_params)
        render json: @class_session
      end

      # DELETE /api/v1/class_sessions/:id
      def destroy
        @class_session.destroy!
        head :no_content
      end

      # GET /api/v1/class_sessions/:id/roster
      def roster
        enrollments = @class_session.enrollments.includes(:student)
        render json: enrollments.map { |e|
          {
            enrollment_id: e.id,
            grade:         e.grade,
            student: {
              id:        e.student.id,
              full_name: e.student.full_name,
              email:     e.student.email
            }
          }
        }
      end

      # POST /api/v1/class_sessions/:id/enroll
      # Body: { student_id: 42 }
      def enroll
        enrollment = @class_session.enrollments.create!(
          student_id: params.require(:student_id)
        )
        render json: enrollment, status: :created
      end

      # PATCH /api/v1/class_sessions/:id/update_grade
      # Body: { student_id: 42, grade: "B+" }
      def update_grade
        enrollment = @class_session.enrollments.find_by!(student_id: params.require(:student_id))
        enrollment.update!(grade: params.require(:grade))
        render json: enrollment
      end

      private

      def set_class_session
        @class_session = ClassSession.find(params[:id])
      end

      def class_session_params
        params.require(:class_session).permit(:course_id, :semester_id, :teacher_id, :room, :schedule)
      end
    end
  end
end
