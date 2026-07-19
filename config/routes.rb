Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Student routes
  # GET /students/:id          — student info
  # GET /students/:id/courses  — student's enrolled courses with grades
  resources :students, only: [:show] do
    member do
      get :courses
    end
  end
end
