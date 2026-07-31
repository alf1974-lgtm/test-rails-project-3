Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Student-facing routes
      resources :students, only: [:show] do
        member do
          get :courses
        end
      end

      # Admin / general read routes (handy for testing)
      resources :users,        only: [:index, :show]
      resources :departments,  only: [:index, :show]
      resources :courses,      only: [:index, :show]
      resources :semesters,    only: [:index, :show]
      resources :class_sessions, only: [:index, :show]
    end
  end
end
