class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end
  
  def show
    @review = Review.find_by(id: params[:id])
  end
  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(content_title:"#{params[:content_title]}", content: "#{params[:content]}", book_id: "#{params[:book_id]}")
    
    if @review.save
      flash[:notice] ="まとめを作成しました!!" 
      redirect_to("/reviews/index") 
    else
      render("reviews/new")
    end
  end
  
  def destroy
    @review = Review.find_by(id: params[:id])
    
    if @review.destroy
      flash[:notice]="まとめを削除しました"
    end
    redirect_to("/reviews/index") 
  end
  
  def edit
    @review = Review.find_by(id: params[:id])
  end 
  
  def update
    @review = Review.find_by(id: params[:id])
    @review.update(content_title: params[:content_title], content: params[:content])
    
    if @review.save
      flash[:notice] = "編集しました"
      redirect_to("/reviews/index")
    else
      render("reviews/edit")
    end
  end
end
