Rails.application.routes.draw do
  # Student-facing routes
  namespace :api do
    namespace :v1 do
      resources :students, only: [:show] do
        member do
          get :courses
        end
      end
    end
  end
end
