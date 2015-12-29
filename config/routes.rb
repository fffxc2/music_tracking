Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :songs
  resources :artists

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  namespace :api do
    get '/artist', to: 'artists#index', defaults: { :format => 'json' }
  end

  root 'songs#index'
end
