Rails.application.routes.draw do
  root 'videos#index'
  resources :videos, only: %i[index show edit update]
  resources :presenters
  resources :description_templates

  # Authenticate to YouTube Data API V3
  get '/youtube_sessions', to: 'youtube_sessions#new'
  get '/youtube_sessions/callback', to: 'youtube_sessions#callback'
end
