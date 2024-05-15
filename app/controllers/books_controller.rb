# app/controllers/books_controller.rb
class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search]

  def search
    query = params[:query]
    @books = FetchBooksService.new(query).call
  end

  def create
    book = Book.new(book_params)
    if book.save
      redirect_to books_path, notice: 'Book was successfully saved to your library.'
    else
      redirect_to search_books_path, alert: 'Failed to save the book.'
    end
  end

  def index
    @books = Book.all
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
