Rails.application.routes.draw do
  devise_for :users

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root to: "pages#home"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts, only: %i[create]
    end
  end
  resources :posts, only: %i[index show edit update destroy] do
    member do
      get :render_post_partial
    end
    collection do
      get :sort
    end
  end
end
