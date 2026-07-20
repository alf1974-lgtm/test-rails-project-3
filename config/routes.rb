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
      resources :users,        only: [:index, :show, :create, :update, :destroy]
      resources :departments,  only: [:index, :show, :create, :update, :destroy]
      resources :courses,      only: [:index, :show, :create, :update, :destroy]
      resources :semesters,    only: [:index, :show, :create, :update, :destroy]
      resources :class_sessions, only: [:index, :show, :create, :update, :destroy] do
        member do
          get  :roster          # list all students + grades
          post :enroll          # enroll a student
          patch :update_grade   # update a student's grade
        end
      end
    end
  end

  # Health check
  get "/up", to: proc { [200, {}, ["OK"]] }
end
