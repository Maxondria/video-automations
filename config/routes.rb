Rails.application.routes.draw do
  root 'videos#index'
  resources :videos, only: %i[index show edit update]
  resources :presenters
  resources :description_templates
end
