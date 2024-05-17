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
          model: "gpt-4o",
          messages: [
            { role: "system", content: "You are a helpful assistant. Please respond only with a valid JSON array and no other text." },
            { role: "user", content: "Provide me with 5 books that shaped the worldview of #{query} in a JSON format. Each book should include the title, author, a small description, and a source attribute, providing the context in which they mentioned it. Ensure the response is a valid JSON array with objects containing these fields: title, author, description, and source." }
          ]
        }
      )
      Rails.logger.info("OpenAI API response: #{response.inspect}")
      response_text = response.dig('choices', 0, 'message', 'content').strip

      # Ensure the response starts and ends with JSON array brackets
      response_text = response_text[response_text.index('[')..response_text.rindex(']')+1]

      @books = JSON.parse(response_text)
      Rails.logger.info("Parsed books: #{@books.inspect}")

      # validate the response
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
