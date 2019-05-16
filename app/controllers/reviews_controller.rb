class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end
  
  def new
  end
  
  def create
    @review = Review.new(content:"params[:content]")
  end
end
