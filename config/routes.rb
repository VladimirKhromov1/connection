Rails.application.routes.draw do
  devise_for :accounts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "public#home"

  get "browse" => "browse#browse", as: :browse
  post "approve/:id" => "browse#approve", as: :approve_user
  get "/matches" => "browse#matches", as: :matches
  post "decline/:id" => "browse#decline", as: :decline_user
end
