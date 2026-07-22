Rails.application.routes.draw do
  # Health check
  get "/up", to: proc { [200, {}, ["OK"]] }

  # Student-facing routes
  namespace :api do
    namespace :v1 do
      # GET /api/v1/students/:id          — student profile
      # GET /api/v1/students/:id/courses  — courses the student is enrolled in
      resources :students, only: [:show] do
        get :courses, on: :member
      end
    end
  end
end
