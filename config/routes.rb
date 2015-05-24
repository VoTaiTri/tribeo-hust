Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  root 'pages#home'

  namespace :admin do
    root "dashboard#home"
    resources :users
    resources :subjects ,except: :show
    resources :courses
    resources :terms
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resources :subjects
    resources :courses
  end
  
  resources :subjects, only: [:index, :show]
  resources :courses, only: :show
end
