Rails.application.routes.draw do
  root 'videos#index'

  devise_for :users

  get 'categories/index'
  get 'categories/new'
  get 'categories/edit'

  resources :videos, only: %i[index show edit update] do
    # collection do
    #   post 'sync' -- /vidoes/sync
    # end

    member do
      post :sync # -- /videos/:id/sync
      get :thumb
      post :thumb_upload
    end
  end

  resources :presenters
  resources :description_templates
  resources :categories, only: %i[index new create edit update]

  # Authenticate to YouTube Data API V3
  get '/youtube_sessions', to: 'youtube_sessions#new'
  get '/youtube_sessions/callback', to: 'youtube_sessions#callback'
end
