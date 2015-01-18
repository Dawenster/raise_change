Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root "pages#landing"
  
  get "about" => "pages#about", as: :about

  resources :campaigns
  resources :users, :only => [:show]
end
