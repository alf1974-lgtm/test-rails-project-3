class ApplicationController < ActionController::API
  private

  def render_not_found(resource = "Record")
    render json: { error: "#{resource} not found" }, status: :not_found
  end
end
