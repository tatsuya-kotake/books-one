class UsersController < ApplicationController
  
  before_action :authenticate_user, {only: [:index, :show, :destroy]}
  before_action :forbid_login_user, {only: [:login, :login_form]}
  before_action :ensure_current_user, {only: [:edit, :update, :destroy]}
  
  def index
    @users = User.all
    
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @books = Book.where(user_id: @user.id)
    
  end 
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(name: params[:name], email: params[:email], password: params[:password], image_name: "default.jpg")
    @user.save
    if @user.save
      flash[:notice] = "ユーザーを登録しました"
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end
  
  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.update(name: params[:name], email: params[:email], password: [:password])
    
    if params[:image_name]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image_name]
      File.binwrite("public/user_image/#{@user.image_name}",image.read)
    end
    
    if @user.save
      flash[:notice] = "編集しました"
      redirect_to("/users/#{@user.id}")
    else
      flash[:notice] = "編集できませんでした"
      render("users/edit")
    end
  end
  
  def login_form
    @user = User.new
  end
  
  def login
    @user = User.find_by(email: params[:email])
    
    if @user && @user.authenticate(params[:password])
      flash[:notice] = "ログインしました"
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
    else
      flash[:danger] = "ログインできません"
      redirect_to("/login")
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    
    @reviews = Review.where(user_id: @user.id)
    @reviews.each do |review|
      review.destroy
    end
    
    @books = Book.where(user_id: @user.id)
    @books.each do |book|
      book.destroy
    end
    
    @user.destroy
    if @user.destroy
      flash[:notice] = "ユーザーを削除しました"
      redirect_to("/users/new")
    end
  end
  
  private
  
  def ensure_current_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/users/#{@current_user.id}")
    end
  end
  
end
