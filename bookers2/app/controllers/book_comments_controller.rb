class BookCommentsController < ApplicationController
  
  # ローカル変数からインスタンス変数へ変更
  # bookとcomment
  
  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new(book_comment_params)
    @comment.user_id = current_user.id
    @comment.book_id = @book.id
    @comment.save
    render :comment
    # redirect_to book_path(@book)
    
    
  end

  def destroy
    @book = Book.find(params[:book_id])
    BookComment.find(params[:id]).destroy
    render :comment
  end
  
  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end