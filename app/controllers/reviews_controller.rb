class ReviewsController < ApplicationController
  
  before_action :authenticate_user 
  before_action :ensure_current_user, {only: [:new, :create, :edit, :update]}
    
  def index
    @books = Book.where(isbn: params[:isbn])
    @book = @books.first   
    
    if @books == nil
      flash[:notice] = "他の書評はありません"
      redirect_to("/books/search")
    end
  end
  
  def show
    @review = Review.find_by(id: params[:id])
    @book = Book.find_by(id: @review.book_id)
  end
  
  def new
    @review = Review.new
    @book = Book.find_by(id: params[:book_id])
  end
  
  def create
    @review = Review.new(content_title:"#{params[:content_title]}", content: "#{params[:content]}", book_id: "#{params[:book_id]}", user_id: "#{@current_user.id}")
    
    if @review.save
      flash[:notice] ="まとめを作成しました!!" 
      redirect_to("/books/#{@review.user_id}/index") 
    else
      flash[:danger] ="まとめを作成できませんでした"
      redirect_to("/reviews/#{params[:book_id]}/new")
    end
  end
  
  def destroy
    @review = Review.find_by(id: params[:id])
    @book = Book.find_by(id: @review.book_id) 
    if @review.destroy
      flash[:notice]="まとめを削除しました"
    end
      redirect_to("/books/#{@book.user_id}/index")
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
      redirect_to("/books/#{@current_user.id}/index")
    else
      flash[:danger] = "編集できませんでした"
      redirect_to("/reviews/#{params[:book_id]}/edit")
    end
  end
  
  private

  def ensure_current_user
    @book = Book.find_by(id: params[:book_id])
    if @current_user.id != @book.user_id
      flash[:notice] = "権限がありません"
      redirect_to("/users/#{@current_user.id}")
    end
  end
end
