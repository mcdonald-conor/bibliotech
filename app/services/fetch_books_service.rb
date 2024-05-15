require "openai"
class FetchBooksService
  def initialize(query)
    @query = query
    @client = OpenAI::Client.new(api_key: "sk-proj-FDIwKexunxGTonUchJm6T3BlbkFJbfiQxN2W8CPlcOO5rgEI")
  end

  def call
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",  # Use the correct model identifier for your version
        messages: [
          { role: "system", content: "You are a helpful assistant." },
          { role: "user", content: "Can you provide me with a list of 5 books about #{@query} with their titles and authors in a JSON format?" }
        ]
      }
    )

    books_json = response.dig('choices', 0, 'message', 'content')
    JSON.parse(books_json)
  end
end
