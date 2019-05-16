class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end
  
  def show
    @reviews = Review.find_by(id: params[:id])
  end
  
  def new
  end
  
  def create
    @review = Review.new(content: "#{params[:content]}")
    @review.save
    redirect_to("/reviews/index") 
  end
end
