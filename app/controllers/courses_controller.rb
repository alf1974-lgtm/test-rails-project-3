class CoursesController < ApplicationController
  def index
    render json: Course.includes(:department).order(:code).map { |c|
      { id: c.id, name: c.name, code: c.code, department: c.department.name }
    }
  end

  def show
    course = Course.includes(:department, :class_sessions).find_by(id: params[:id])
    return render_not_found("Course") unless course

    render json: {
      id:          course.id,
      name:        course.name,
      code:        course.code,
      description: course.description,
      department:  { id: course.department.id, name: course.department.name }
    }
  end
end
