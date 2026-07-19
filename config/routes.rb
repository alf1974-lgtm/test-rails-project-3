Rails.application.routes.draw do
  # Student routes
  namespace :api do
    namespace :v1 do
      # GET /api/v1/students/:id        — student profile
      # GET /api/v1/students/:id/courses — student's class sessions (with grades)
      resources :students, only: [:show] do
        member do
          get :courses
        end
      end
    end
  end
end
