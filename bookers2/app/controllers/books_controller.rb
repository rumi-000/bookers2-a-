class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user=@book.user
    @book_comment = BookComment.new
  end

#def index
  #@books = Book.all
  #@book= Book.new
  #@user = current_user
#end

def index
    @books = Book.all
    @book= Book.new
    @user = current_user
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse
    @book = Book.new
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
