json.extract! message, :id, :email, :content, :created_at, :updated_at
json.url message_url(message, format: :json)
