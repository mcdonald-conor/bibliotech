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
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: "You are a helpful assistant. Do not reply to my message other than with the answer to my question." },
            { role: "user", content: "Can you provide me with a list of 5 books about #{query} in a JSON format? Each book should include the title, author, a small description, and the source where the book was mentioned. Ensure the response is a valid JSON array with objects containing these fields: title, author, description, and source." }
          ]
        }
      )
      Rails.logger.info("OpenAI API response: #{response.inspect}")
      response_text = response.dig('choices', 0, 'message', 'content')
      @books = JSON.parse(response_text)
      Rails.logger.info("Parsed books: #{@books.inspect}")

      # Validate and filter the response
      @books = @books.select do |book|
        book.is_a?(Hash) && book.key?('title') && book.key?('author') && book.key?('description') && book.key?('source')
      end
      Rails.logger.info("Validated books: #{@books.inspect}")

    rescue JSON::ParserError => e
      Rails.logger.error("JSON parsing error: #{e.message}")
      @books = []
    rescue => e
      Rails.logger.error("Unexpected error: #{e.message}")
      @books = []
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
    params.require(:book).permit(:title, :author, :description, :source)
  end
end
