Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }

  root "pages#landing"
  
  get "about" => "pages#about", as: :about

  resources :organizations, :only => [:create, :update]

  get "create-campaign" => "campaigns#new", as: :new_campaign
  get "edit-campaign/:id" => "campaigns#edit", as: :edit_campaign
  resources :campaigns, :only => [:index, :show, :destroy]

  get ":campaign_id/donate" => "donations#new", as: :new_donation
  resources :donations, :only => [:create, :destroy]

  delete "delete-credit-card" => "users#delete_credit_card", as: :delete_credit_card
  resources :users, :only => [:show]
end
