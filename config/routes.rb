Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :students, only: [:show] do
        collection do
          get :me
        end
        resources :courses, only: [:index]
      end
    end
  end
end
