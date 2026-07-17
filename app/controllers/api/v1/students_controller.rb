module Api
  module V1
    class StudentsController < BaseController
      before_action :set_student

      # GET /api/v1/students/:id
      def show
        render json: StudentSerializer.new(@student).as_json
      end

      # GET /api/v1/students/:id/courses
      def courses
        render json: StudentCoursesSerializer.new(@student).as_json
      end

      private

      def set_student
        @student = User.find(params[:id])
        return if @student.student?

        render json: { error: 'User is not a student' }, status: :unprocessable_content
      end
    end
  end
end
