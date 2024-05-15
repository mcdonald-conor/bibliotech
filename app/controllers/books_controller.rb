# app/controllers/books_controller.rb
require "openai"

class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search]

  def search
    query = params[:query]
    client = OpenAI::Client.new(
      access_token: ENV['OPENAI_API_KEY'],
      log_errors: true # Highly recommended in development, so you can see what errors OpenAI is returning. Not recommended in production.
    )

    begin
      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",  # Use the correct model identifier for your version
          messages: [
            { role: "system", content: "You are a helpful assistant. Do not reply to my message other than with the answer to my question." },
            { role: "user", content: "Can you provide me with a list of 5 books about #{query} with their titles and authors in a JSON format?" }
          ]
        }
      )
      Rails.logger.info("OpenAI API response: #{response.inspect}")
      response_text = response.dig('choices', 0, 'message', 'content')

      # Directly parse the JSON from the response text
      @books = JSON.parse(response_text)["books"]
    end
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
