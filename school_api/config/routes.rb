Rails.application.routes.draw do
  resources :students, only: [:show] do
    member do
      get :class_sessions
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
