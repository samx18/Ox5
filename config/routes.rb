Rails.application.routes.draw do
  root  'static_pages#home'
  match '/about',   to: 'static_pages#about',   via: 'get'
  resources :contacts, only: [:new, :create]
end
