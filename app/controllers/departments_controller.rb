class DepartmentsController < ApplicationController
  def index
    render json: Department.order(:name).map { |d|
      { id: d.id, name: d.name, course_count: d.courses.count }
    }
  end

  def show
    department = Department.includes(:courses).find_by(id: params[:id])
    return render_not_found("Department") unless department

    render json: {
      id:      department.id,
      name:    department.name,
      courses: department.courses.map { |c|
        { id: c.id, name: c.name, code: c.code, description: c.description }
      }
    }
  end
end
