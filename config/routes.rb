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
  get "/up", to: proc { [200, {}, [{ status: "ok" }.to_json]] }
end
