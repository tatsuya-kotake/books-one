Rails.application.routes.draw do
  
  get "reviews/index" => "reviews#index"
  get "reviews/new" => "reviews#new"
  post "reviews/create" => "reviews#create"
  get "reviews/:id" => "reviews#show"
  
  get "/" => "home#top"
end
