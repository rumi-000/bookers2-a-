class BooksController < ApplicationController

  def show
    @Book = Book.find(params[:id])
    @user=@Book.user
    @book_comment = BookComment.new
  end


  def index
    @books = Book.all
    @book= Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else @books = Book.all
         @user = current_user
    render 'users/show'
    end
  end



  #def edit
    #@book = Book.find(params[:id])
  #
  
  def edit
 @book = Book.find(params[:id])
 user_id =@book.user.id.to_i
 unless user_id == current_user.id
  redirect_to books_path
 end
end
  

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end


  def destroy
    @Book=Book.find(params[:id])
    @Book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path
  end

  private

 def book_params
   params.require(:book).permit(:title, :body)
 end
  
end
