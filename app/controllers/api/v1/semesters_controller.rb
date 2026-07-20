module Api
  module V1
    class SemestersController < ApplicationController
      before_action :set_semester, only: [:show, :update, :destroy]

      def index
        render json: Semester.all.order(:start_date)
      end

      def show
        render json: @semester.as_json(include: :class_sessions)
      end

      def create
        semester = Semester.create!(semester_params)
        render json: semester, status: :created
      end

      def update
        @semester.update!(semester_params)
        render json: @semester
      end

      def destroy
        @semester.destroy!
        head :no_content
      end

      private

      def set_semester
        @semester = Semester.find(params[:id])
      end

      def semester_params
        params.require(:semester).permit(:name, :start_date, :end_date)
      end
    end
  end
end
