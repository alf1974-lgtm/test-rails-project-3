Rails.application.routes.draw do
  # Student-facing endpoints
  # GET /students/:id          → student profile
  # GET /students/:id/courses  → student's enrolled courses with grades
  resources :students, only: [ :show ] do
    member do
      get :courses
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
