json.extract! book, :id, :name, :author, :publisher, :price, :quantity, :created_at, :updated_at
json.url book_url(book, format: :json)
