module Api
  module V1
    class CoursesController < ApplicationController
      def index
        courses = Course.includes(:department).all
        render json: courses.map { |c| course_json(c) }
      end

      def show
        course = Course.includes(:department).find_by(id: params[:id])
        return render_not_found("Course") unless course

        render json: course_json(course)
      end

      private

      def course_json(course)
        {
          id:          course.id,
          name:        course.name,
          code:        course.code,
          credits:     course.credits,
          description: course.description,
          department: {
            id:   course.department.id,
            name: course.department.name
          }
        }
      end
    end
  end
end
