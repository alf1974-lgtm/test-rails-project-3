module Api
  module V1
    class DepartmentsController < ApplicationController
      before_action :set_department, only: [:show, :update, :destroy]

      def index
        render json: Department.all.order(:name)
      end

      def show
        render json: @department.as_json(include: :courses)
      end

      def create
        dept = Department.create!(department_params)
        render json: dept, status: :created
      end

      def update
        @department.update!(department_params)
        render json: @department
      end

      def destroy
        @department.destroy!
        head :no_content
      end

      private

      def set_department
        @department = Department.find(params[:id])
      end

      def department_params
        params.require(:department).permit(:name, :description)
      end
    end
  end
end
