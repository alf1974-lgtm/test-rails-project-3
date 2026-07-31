Rails.application.routes.draw do
  # Student-facing routes
  scope "/students/:id" do
    get "/",       to: "students#show",   as: :student
    get "/courses", to: "students#courses", as: :student_courses
  end

  # Optional: basic read-only index routes for reference
  resources :departments,    only: [:index, :show]
  resources :courses,        only: [:index, :show]
  resources :semesters,      only: [:index, :show]
  resources :class_sessions, only: [:index, :show]
  resources :users,          only: [:index, :show]
end
