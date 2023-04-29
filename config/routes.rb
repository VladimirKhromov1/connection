Rails.application.routes.draw do
  resources :locations
  resources :messages
  devise_for :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "public#home"

  get "dates" => "locations#dates", as: :dates
  get "show/:sender_id/:receiver_id" => "accounts#show", as: :show
  get "date/:creator_id/:recipient_id" => "locations#date"
  get "show_date/:date_id" => "locations#show_date", as: :show_date
  get "browse" => "browse#browse", as: :browse
  post "approve/:id" => "browse#approve", as: :approve_user
  get "/matches" => "browse#matches", as: :matches
  post "decline/:id" => "browse#decline", as: :decline_user
  get "approve_date/:id" => "locations#approve_date"
  get "decline_date/:id" => "locations#decline_date"
  get "/statistics" => "statistics#index", as: :statistics_path
  put "check_dates" => "locations#check_dates"
  get "/top" => "accounts#top", as: :top_path
end
