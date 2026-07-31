class SemestersController < ApplicationController
  def index
    render json: Semester.order(:start_date).map { |s|
      { id: s.id, name: s.name, start_date: s.start_date, end_date: s.end_date }
    }
  end

  def show
    semester = Semester.find_by(id: params[:id])
    return render_not_found("Semester") unless semester

    render json: {
      id:         semester.id,
      name:       semester.name,
      start_date: semester.start_date,
      end_date:   semester.end_date
    }
  end
end
