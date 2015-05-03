Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'

  namespace :admin do
  end
end