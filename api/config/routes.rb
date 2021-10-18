Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :records
      resources :artists
      resources :libraries
      resources :recordlibraries
    end
  end

  root to: "home#index"

  post "refresh", controller: :refresh, action: :create
  post "signin", controller: :signin, action: :create
  post "signup", controller: :signup, action: :create
  delete "signin", controller: :signin, action: :destroy
end
