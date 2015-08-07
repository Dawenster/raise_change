Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  scope "/admin" do
    post "add-org-admin" => "admins#add_org_admin", as: :add_org_admin
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations", :sessions => "sessions" }

  root "pages#landing"
  
  get "how-it-works" => "pages#how_it_works", as: :how_it_works
  get "about" => "pages#about", as: :about
  get "faq" => "pages#faq", as: :faq
  get "terms" => "pages#terms", as: :terms
  get "privacy" => "pages#privacy", as: :privacy

  get "create-campaign" => "campaigns#new", as: :new_campaign
  get "edit-campaign/:id" => "campaigns#edit", as: :edit_campaign
  resources :campaigns do
    get :autocomplete_organization_name, :on => :collection
  end
  resources :campaigns, :only => [:index, :show, :create, :update, :destroy]

  get ":campaign_id/donate" => "donations#new", as: :new_donation
  resources :donations, :only => [:create, :destroy]
  post "/donations/add-donation-message" => "donations#add_donation_message", as: :add_donation_message

  resources :journal_entries, :except => [:index, :show]

  post "create-or-update-credit-card" => "users#create_or_update_credit_card", as: :create_or_update_credit_card
  delete "delete-credit-card" => "users#delete_credit_card", as: :delete_credit_card
  resources :users, :only => [:show]

  post "follow/:user_id" => "users#follow", as: :follow
  delete "follow/:user_id" => "users#unfollow", as: :unfollow

  get "charity-admin" => "admins#index", as: :charity_admin
  post "admin/verify/:journal_entry_id" => "admins#verify", as: :verify_journal_entry
  post "admin/verify-all/:org_id" => "admins#verify_all", as: :verify_all_journal_entries_for_org
end
