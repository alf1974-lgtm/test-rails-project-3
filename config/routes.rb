Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Student-facing routes
      resources :students, only: [:show] do
        member do
          get :courses
        end
      end

      # Admin / general read routes (handy for seeding verification)
      resources :departments,    only: [:index, :show]
      resources :courses,        only: [:index, :show]
      resources :semesters,      only: [:index, :show]
      resources :class_sessions, only: [:index, :show]
      resources :users,          only: [:index, :show]
    end
  end

  get "/health", to: proc { [200, {}, ["ok"]] }
end
