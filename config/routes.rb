Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations", :sessions => "sessions" }

  root "pages#landing"
  
  get "how-it-works" => "pages#how_it_works", as: :how_it_works
  get "about" => "pages#about", as: :about

  resources :organizations, :only => [:create, :update]

  get "create-campaign" => "campaigns#new", as: :new_campaign
  get "edit-campaign/:id" => "campaigns#edit", as: :edit_campaign
  resources :campaigns, :only => [:index, :show, :destroy]

  get ":campaign_id/donate" => "donations#new", as: :new_donation
  resources :donations, :only => [:create, :destroy]

  resources :journal_entries, :except => [:index, :show]

  post "create-or-update-credit-card" => "users#create_or_update_credit_card", as: :create_or_update_credit_card
  delete "delete-credit-card" => "users#delete_credit_card", as: :delete_credit_card
  resources :users, :only => [:show]

  post "follow/:user_id" => "users#follow", as: :follow
  delete "follow/:user_id" => "users#unfollow", as: :unfollow
end
