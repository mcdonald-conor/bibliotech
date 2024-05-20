class Book < ApplicationRecord
  belongs_to :user
  belongs_to :collection, optional: true

  def cover_url
    "https://covers.openlibrary.org/b/isbn/#{isbn}-L.jpg"
  end
end
