class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit]

  def new
    @book = Book.new
  end

  def create
    @books = Book.all
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
     render :index
    end
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all

  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
    @books = Book.all

    @book_user = @book.user
    @book_user_name = @book.user.name
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
    redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
    render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end


  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end

end
