module Api
  module V1
    class StudentsController < ApplicationController
      def show
        @student = User.find(params[:id])
        render json: student_json(@student)
      end

      def me
        # For now, we'll use a query parameter to identify the student
        # In a real app, this would come from authentication
        student_id = params[:student_id]
        @student = User.find(student_id)
        render json: student_json(@student)
      end

      def courses
        @student = User.find(params[:student_id])
        @courses = @student.enrollments.includes(class_session: :course).map { |e| e.class_session.course }.uniq
        render json: @courses.map { |course| course_json(course) }
      end

      private

      def student_json(student)
        {
          id: student.id,
          name: student.name,
          email: student.email,
          role: student.role
        }
      end

      def course_json(course)
        {
          id: course.id,
          name: course.name,
          code: course.code,
          department: {
            id: course.department.id,
            name: course.department.name
          }
        }
      end
    end
  end
end
