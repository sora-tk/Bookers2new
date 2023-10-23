class BooksController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
      if @book.save
        flash[:notice] = "You have created book successfully."
        redirect_to book_path(@book.id)
      else
        @user = User.find(current_user.id)
        @books = Book.all
        render :index
      end
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def edit
    
    @user = current_user
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  def update
    
    @book = Book.find(params[:id])
      if @book.update(book_params)
        flash[:notice] = "Book was successfully updated."
        redirect_to book_path(@book.id)
      else
        @user = current_user
        render :edit
      end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  
  def correct_user
    book = Book.find(params[:id])
    user = book.user
    redirect_to books_path if user != current_user
  end

end