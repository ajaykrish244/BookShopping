json.extract! user, :id, :username, :name, :email, :address, :credit_card_number, :phone_number, :created_at, :updated_at
json.url user_url(user, format: :json)
