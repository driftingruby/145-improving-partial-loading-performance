Rails.application.routes.draw do
  resources :quotes
  resources :movies
  root to: 'movies#index'
end
