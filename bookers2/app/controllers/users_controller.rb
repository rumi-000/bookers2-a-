class UsersController < ApplicationController
  # before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
end

  def edit
  user_id = params[:id].to_i
  unless user_id == current_user.id
  redirect_to user_path(current_user)
  #redirect_to books_path
  end
  @user=current_user
 end


  def update
  user_id = params[:id].to_i
    unless user_id == current_user.id
    redirect_to books_path
    end
  @user=current_user
   if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(current_user)
   else 
      flash[:notice] = "error"
      render :edit
   end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
    def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
   end
end