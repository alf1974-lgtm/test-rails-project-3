Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :students, only: [:show] do
        member do
          get :courses
        end
      end
    end
  end

  # Health check
  get 'up' => 'rails/health#show', as: :rails_health_check
end
