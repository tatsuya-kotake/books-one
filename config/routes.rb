Rails.application.routes.draw do
  
  get "reviews/index" => "reviews#index"
  get "reviews/:book_id/new" => "reviews#new"
  post "reviews/:book_id/create" => "reviews#create"
  post "reviews/:id/destroy" => "reviews#destroy"
  get "reviews/:id" => "reviews#show"
  get "reviews/:book_id/edit" => "reviews#edit"
  post "reviews/:book_id/update" => "reviews#update"
  
  
  get "books/index" => "books#index"
  get "books/search" => "books#search"
  get "books/new" => "books#new"
  
  post "books/:isbn/create" => "books#create"
  post "books/:isbn/destroy" => "books#destroy"
  
  get "books/:id" => "books#show"
  
  get "/" => "home#top"
  
end
