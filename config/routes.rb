Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'images#index' # default path
  resources :images, only: %i[new create show index destroy]
  get 'tags/:tag', to: 'images#index', as: :tag
  root 'application#home'

  resources :feedbacks, only: [:new]

  namespace :api do
    resource :feedbacks, only: [:create]
  end
end
