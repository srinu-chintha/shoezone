Rails.application.routes.draw do
  resources :line_items
  resources :carts
  get 'gallery/index'
  get 'gallery/search'
  get '/gallery/checkout'
  post '/gallery/checkout'

  get '/gallery/search'
  post '/gallery/search'
  
  get '/gallery/purchase_complete'

  resources :stores
  get 'admin/login'
  devise_for :users
  get 'home/index'
  root "gallery#index"
  get "admin/login"
  post "admin/login"
  get "/admin/logout"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
