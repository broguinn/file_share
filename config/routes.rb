FileShare::Application.routes.draw do
  match '/home' => 'static_pages#home', via: 'get'

  resources :packages, only: [:new, :create, :show]
  resources :attachments, only: [:show]

  root 'static_pages#home'
end
