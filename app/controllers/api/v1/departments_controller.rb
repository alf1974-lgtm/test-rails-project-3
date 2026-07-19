module Api
  module V1
    class DepartmentsController < ApplicationController
      def index
        departments = Department.includes(:courses).order(:name)
        render json: departments.map { |d| department_json(d) }
      end

      def show
        department = Department.includes(:courses).find(params[:id])
        render json: department_json(department)
      end

      private

      def department_json(dept)
        {
          id:      dept.id,
          name:    dept.name,
          courses: dept.courses.map { |c| { id: c.id, name: c.name, code: c.code, credits: c.credits } }
        }
      end
    end
  end
end
