Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Student-facing routes
      resources :students, only: [:show] do
        # GET /api/v1/students/:id/courses
        get :courses, on: :member
      end

      # Supporting read-only resources
      resources :departments,    only: [:index, :show]
      resources :courses,        only: [:index, :show]
      resources :semesters,      only: [:index, :show]
      resources :class_sessions, only: [:index, :show]
    end
  end

  # Health check
  get "/up", to: proc { [200, {}, ["OK"]] }
end
