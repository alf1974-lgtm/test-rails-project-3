module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_course, only: [:show, :update, :destroy]

      def index
        courses = Course.includes(:department).order(:course_code)
        render json: courses.as_json(include: :department)
      end

      def show
        render json: @course.as_json(include: [:department, :class_sessions])
      end

      def create
        course = Course.create!(course_params)
        render json: course, status: :created
      end

      def update
        @course.update!(course_params)
        render json: @course
      end

      def destroy
        @course.destroy!
        head :no_content
      end

      private

      def set_course
        @course = Course.find(params[:id])
      end

      def course_params
        params.require(:course).permit(:name, :course_code, :description, :credits, :department_id)
      end
    end
  end
end
