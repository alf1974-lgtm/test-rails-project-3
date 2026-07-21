Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Student-facing routes
  namespace :api do
    namespace :v1 do
      # GET /api/v1/students/:id        — student profile
      # GET /api/v1/students/:id/courses — student's enrolled courses
      resources :students, only: [:show] do
        get :courses, on: :member
      end
    end
  end
end
