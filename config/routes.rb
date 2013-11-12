FileShare::Application.routes.draw do
  match '/home' => 'static_pages#home', via: 'get'

  resources :packages, only: [:new, :create, :show]
  resources :senders, only: [:create]
  resources :recipients, only: [:create]
  resources :attachments, only: [:create, :show]

  root 'static_pages#home'
end
