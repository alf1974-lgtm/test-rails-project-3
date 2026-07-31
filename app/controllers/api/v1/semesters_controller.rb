module Api
  module V1
    class SemestersController < ApplicationController
      def index
        semesters = Semester.order(:start_date)
        render json: semesters.map { |s| semester_json(s) }
      end

      def show
        semester = Semester.find(params[:id])
        render json: semester_json(semester)
      end

      private

      def semester_json(semester)
        {
          id:         semester.id,
          name:       semester.name,
          start_date: semester.start_date,
          end_date:   semester.end_date
        }
      end
    end
  end
end
