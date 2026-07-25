module Api
  module V1
    class DepartmentsController < ApplicationController
      def index
        departments = Department.all.order(:name)
        render json: departments.map { |d| department_json(d) }
      end

      def show
        department = Department.find(params[:id])
        render json: department_json(department).merge(
          courses: department.courses.map { |c| course_summary(c) }
        )
      end

      private

      def department_json(dept)
        { id: dept.id, name: dept.name, description: dept.description }
      end

      def course_summary(course)
        { id: course.id, code: course.code, name: course.name, credits: course.credits }
      end
    end
  end
end
