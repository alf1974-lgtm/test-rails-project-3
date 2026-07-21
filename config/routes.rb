Rails.application.routes.draw do
  # Student-facing routes
  namespace :api do
    namespace :v1 do
      # GET /api/v1/students/:id        — student profile
      # GET /api/v1/students/:id/courses — courses the student is enrolled in
      resources :students, only: [:show] do
        member do
          get :courses
        end
      end
    end
  end
end
