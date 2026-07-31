module Api
  module V1
    class DepartmentsController < ApplicationController
      def index
        departments = Department.includes(:courses).all
        render json: departments.map { |d| department_json(d) }
      end

      def show
        department = Department.includes(:courses).find_by(id: params[:id])
        return render_not_found("Department") unless department

        render json: department_json(department, include_courses: true)
      end

      private

      def department_json(department, include_courses: false)
        json = {
          id:          department.id,
          name:        department.name,
          description: department.description,
          course_count: department.courses.size
        }
        if include_courses
          json[:courses] = department.courses.map do |c|
            { id: c.id, name: c.name, code: c.code, credits: c.credits }
          end
        end
        json
      end
    end
  end
end
