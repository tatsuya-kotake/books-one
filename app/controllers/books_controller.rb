class BooksController < ApplicationController
  
  before_action :authenticate_user
  before_action :ensure_current_user, {only: [:destroy]}
  
  def index
    @books = Book.where(user_id: params[:user_id])
    
    unless @books.first 
      flash[:notice] = "本棚に本が登録されていません"
      redirect_to("/books/search")
    end
  end
  
  def search
    @books = []
    
    @title = params[:title]
    if @title.present?
      results = RakutenWebService::Books::Book.search({
        title: @title,
        imageFlag: 1,
        hits: 20,
      })
      
      results.each do |result|
        book = Book.new(read(result))
        @books << book
      end
    end
  end
  
  def new
    bookresult = RakutenWebService::Books::Book.search(isbn: params[:isbn])
    @book = Book.new(read(bookresult.first))
  end
  
  def show
    @book = Book.find_by(id: params[:id])
  end
  
  def create
    bookresult = RakutenWebService::Books::Book.search(isbn: params[:isbn])
    @book = Book.new(read(bookresult.first))
    
    if Book.find_by(isbn: @book.isbn, user_id: @current_user.id)
      flash[:notice] = "登録済みです"
    else
      @book.save
    end
    redirect_to("/books/#{@current_user.id}/index")
    
  end 
  
  def destroy
    @book = Book.find_by(id: params[:id])
    @book.destroy
    if @book.destroy
      flash[:notice]="本を本棚から解除しました"
      redirect_to("/books/#{@book.user_id}/index")
    end
  end
  

  private

  def read(result)
    title = result['title']
    author = result['author']
    publisher = result['publisherName']
    isbn = result['isbn']
    img_url = result['largeImageUrl']
    user_id = @current_user.id

    {
      title: title,
      author: author,
      publisher: publisher,
      isbn: isbn,
      img_url: img_url,
      user_id: user_id,
    }
  end
  
  def ensure_current_user
    @book = Book.find_by(id: params[:id])
    if @current_user.id != @book.user_id
      flash[:notice] = "権限がありません"
      redirect_to("/users/#{@current_user.id}")
    end
  end

end