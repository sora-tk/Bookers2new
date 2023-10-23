class UsersController < ApplicationController
  
  before_action :correct_user, only: [:edit, :update]
  # before_action :is_matching_login_user, only: [:edit, :update]
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to user_path(current_user.id)
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
    @book = Book.new

  end

  def update
    # is_matching_login_user
    @user = current_user
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(current_user.id)
    else
    render :edit
    end
  end



  def edit
    # is_matching_login_user
    @user = current_user
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def correct_user
    user = User.find(params[:id])
    redirect_to(user_path(current_user)) if user != current_user
  end
  
#   def is_matching_login_user
#     user = User.find(params[:id])
#     unless user.id == current_user.id
#     redirect_to books_path
#   end
end