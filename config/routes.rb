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

  get "journal-entries" => "journal_entries#index", as: :journal_entries
  get "create-journal-entry" => "journal_entries#new", as: :new_journal_entry
  get "edit-journal-entry/:id" => "journal_entries#edit", as: :edit_journal_entry
  resources :journal_entries, :only => [:create, :update, :destroy]

  post "create-or-update-credit-card" => "users#create_or_update_credit_card", as: :create_or_update_credit_card
  delete "delete-credit-card" => "users#delete_credit_card", as: :delete_credit_card
  resources :users, :only => [:show]
end
