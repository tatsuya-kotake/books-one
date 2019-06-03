Rails.application.routes.draw do
  
  get "/login" => "users#login_form"
  get "/logout" => "users#logout"
  get "users/index" => "users#index"
  get "users/new" => "users#new"
  get "users/:id/edit" => "users#edit"
  get "users/:id" => "users#show"
  post "/login" => "users#login"
  post "users/create" => "users#create"
  post "users/:id/update" => "users#update"
  post "users/:id/destroy" => "users#destroy"
  
  get "reviews/:isbn/index" => "reviews#index"
  get "reviews/:book_id/new" => "reviews#new"
  post "reviews/:book_id/create" => "reviews#create"
  post "reviews/:id/destroy" => "reviews#destroy"
  get "reviews/:id" => "reviews#show"
  get "reviews/:book_id/edit" => "reviews#edit"
  post "reviews/:book_id/update" => "reviews#update"
  
  
  get "books/:user_id/index" => "books#index"
  get "books/search" => "books#search"
  get "books/new" => "books#new"
  
  post "books/:isbn/create" => "books#create"
  post "books/:id/destroy" => "books#destroy"
  
  get "books/:id" => "books#show"
  
  get "/" => "home#top"
  
end
