Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Student routes
  get "students/:id",         to: "students#show",    as: :student
  get "students/:id/courses", to: "students#courses", as: :student_courses
end
