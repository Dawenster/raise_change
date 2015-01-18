Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root "pages#landing"
  
  get "about" => "pages#about", as: :about

  resources :organizations, :only => [:create, :update]

  get "create-campaign" => "campaigns#new", as: :new_campaign
  get "edit-campaign/:id" => "campaigns#edit", as: :edit_campaign
  resources :campaigns, :only => [:index, :show, :destroy]

  resources :users, :only => [:show]
end
