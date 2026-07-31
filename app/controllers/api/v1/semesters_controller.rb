module Api
  module V1
    class SemestersController < ApplicationController
      def index
        semesters = Semester.all.order(year: :desc, term: :asc)
        render json: semesters.map { |s| semester_json(s) }
      end

      def show
        semester = Semester.find_by(id: params[:id])
        return render_not_found("Semester") unless semester

        render json: semester_json(semester)
      end

      private

      def semester_json(semester)
        {
          id:         semester.id,
          name:       semester.name,
          term:       semester.term,
          year:       semester.year,
          start_date: semester.start_date,
          end_date:   semester.end_date
        }
      end
    end
  end
end
