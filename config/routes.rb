Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Student-facing routes
      resources :students, only: [:show] do
        member do
          get :courses
        end
      end
    end
  end
end
