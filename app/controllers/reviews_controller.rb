class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end
  
  def show
    @review = Review.find_by(id: params[:id])
  end
  
  def new
    @review = Review.new
    @book = Book.find_by(id: params[:book_id])
  end
  
  def create
    @review = Review.new(content_title:"#{params[:content_title]}", content: "#{params[:content]}", book_id: "#{params[:book_id]}")
    
    if @review.save
      flash[:notice] ="まとめを作成しました!!" 
      redirect_to("/books/#{@review.book_id}") 
    else
      flash[:danger] ="まとめを作成できませんでした"
      redirect_to("/reviews/#{params[:book_id]}/new")
    end
  end
  
  def destroy
    @review = Review.find_by(id: params[:id])
    @book_id = @review.book_id
     
    if @review.destroy
      flash[:notice]="まとめを削除しました"
    end
      redirect_to("/books/index")
  end
  
  def edit
    @book = Book.find_by(id: params[:book_id])
    @review = Review.find_by(book_id: params[:book_id])
  end 
  
  def update
    @review = Review.find_by(book_id: params[:book_id])
    @review.update(content_title: params[:content_title], content: params[:content])
    
    if @review.save
      flash[:notice] = "編集しました"
      redirect_to("/books/index")
    else
      flash[:danger] = "編集できませんでした"
      redirect_to("/reviews/#{params[:book_id]}/edit")
    end
  end
  
end
