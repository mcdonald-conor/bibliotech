require "openai"
require "net/http"

class BooksController < ApplicationController
  # before_action :authenticate_user!, only: [:save]
  skip_before_action :verify_authenticity_token, only: [:create]

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
            { role: "user", content: "Provide me with 5 books that shaped the worldview of #{query} in a JSON format. Each book should include the title, author, a small description, a source attribute providing the context in which they mentioned it, and an isbn. Ensure the response is a valid JSON array with objects containing these fields: title, author, description, source, and isbn." }
          ]
        }
      )
      Rails.logger.info("OpenAI API response: #{response.inspect}")
      response_text = response.dig('choices', 0, 'message', 'content').strip

      # Ensure the response starts and ends with JSON array brackets
      response_text = response_text[response_text.index('[')..response_text.rindex(']')+1]

      @books = JSON.parse(response_text)
      Rails.logger.info("Parsed books: #{@books.inspect}")

      # Validate the response and fetch cover URLs
      @books = @books.select do |book|
        book.is_a?(Hash) && book.key?('title') && book.key?('author') && book.key?('description') && book.key?('source') && book.key?('isbn')
      end

      # Fetch book covers from OpenLibrary API
      @books.each do |book|
        book['cover_url'] = fetch_cover_url(book['isbn'])
      end

      Rails.logger.info("Books with cover URLs: #{@books.inspect}")

    rescue JSON::ParserError => e
      Rails.logger.error("JSON parsing error: #{e.message}")
      @books = []
    rescue => e
      Rails.logger.error("Unexpected error: #{e.message}")
      @books = []
    end
  end

  def create
    book = current_user.books.build(book_params)

    respond_to do |format|
      if book.save
        # redirect_to books_path, notice: 'Book was successfully saved to your library.'
        format.js { render json: { status: :ok } }
      else
        # redirect_to search_books_path, alert: 'Failed to save the book.'
        format.js { render json: { status: 500 } }
      end
    end
  end

  def index
    @books = current_user.books
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :description, :source, :isbn)
  end

  def fetch_cover_url(isbn)
    url = URI("https://covers.openlibrary.org/b/isbn/#{isbn}-M.jpg")
    default_cover_url = "https://covers.openlibrary.org/b/isbn/978-0345391803-M.jpg"

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == 'https')
    http.open_timeout = 10 # seconds
    http.read_timeout = 10 # seconds

    request = Net::HTTP::Get.new(url)

    begin
      response = http.request(request)
      Rails.logger.info("Fetching cover for ISBN #{isbn}, Response Code: #{response.code}")
      response.code == "200" || response.code == "302" ? url.to_s : default_cover_url
    rescue Net::OpenTimeout, Net::ReadTimeout => e
      Rails.logger.error("Timeout error: #{e.message}")
      "path/to/default/cover.jpg"
    rescue => e
      Rails.logger.error("HTTP request error: #{e.message}")
      "path/to/default/cover.jpg"
    end
  end
end
