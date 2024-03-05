Rails.application.routes.draw do
  devise_for :users

  root to: "posts#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts, only: %i[create]
    end
  end
  resources :posts, only: %i[index show edit update]
end
