Rails.application.routes.draw do
  
  get 'reviews/index' => "reviews#index"
  
  get '/' => "home#top"
end
