Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  root 'pages#home'

  namespace :admin do
    resources :users
    resources :subjects ,except: :show
    resources :courses
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resources :subjects
  end
  
  resources :subjects, only: [:index, :show]
end
