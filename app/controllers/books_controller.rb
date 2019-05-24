class BooksController < ApplicationController
  
  def index
    @books = Book.all
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
    @review = Review.find_by(id: @book.reviewed_id)
  end
  
  def create
    bookresult = RakutenWebService::Books::Book.search(isbn: params[:isbn])
    @book = Book.new(read(bookresult.first))
    
    unless @book.persisted?
      @book.save
    end
    
    redirect_to("/books/index")
  end 
  
  def destroy
    @book = Book.find_by(isbn: params[:isbn])
    @book.destroy
    if @book.destroy
      flash[:notice]="本を本棚から解除しました"
      redirect_to("/books/index")
    end
  end
  

  private

  def read(result)
    title = result['title']
    author = result['author']
    publisher = result['publisherName']
    isbn = result['isbn']
    img_url = result['largeImageUrl']

    {
      title: title,
      author: author,
      publisher: publisher,
      isbn: isbn,
      img_url: img_url,
    }
  end

end