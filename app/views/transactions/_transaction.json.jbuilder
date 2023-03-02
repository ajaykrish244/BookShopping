json.extract! transaction, :id, :transaction_number, :credit_card_number, :address, :phone_number, :quantity, :total_cost, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
