Rails.application.routes.draw do
  
  get 'books/new'
  get "reviews/index" => "reviews#index"
  get "reviews/new" => "reviews#new"
  post "reviews/create" => "reviews#create"
  post "reviews/:id/destroy" => "reviews#destroy"
  get "reviews/:id" => "reviews#show"
  get "reviews/:id/edit" => "reviews#edit"
  post "reviews/:id/update" => "reviews#update"
  
  get "books/index" => "books#index"
  get "books/search" => "books#search"
  get "books/new" => "books#new"
  post "books/create" => "books#create"
  
  get "/" => "home#top"
  
end
