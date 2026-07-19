module Api
  module V1
    class CoursesController < ApplicationController
      def index
        courses = Course.includes(:department).order(:code)
        render json: courses.map { |c| course_json(c) }
      end

      def show
        course = Course.includes(:department).find(params[:id])
        render json: course_json(course)
      end

      private

      def course_json(course)
        {
          id:          course.id,
          name:        course.name,
          code:        course.code,
          description: course.description,
          credits:     course.credits,
          department:  { id: course.department.id, name: course.department.name }
        }
      end
    end
  end
end
