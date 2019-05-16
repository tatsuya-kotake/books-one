Rails.application.routes.draw do
  
  get "reviews/index" => "reviews#index"
  get "reviews/new" => "reviews#new"
  get "reviews/create"=>"reviews#create"
  
  get "/" => "home#top"
end
