json.extract! order, :id, :date, :amount, :received_at, :shipped_at, :cancelled_at, :refunded_at, :email, :street_address_1, :street_address_2, :city, :state, :zip, :country, :created_at, :updated_at
json.url order_url(order, format: :json)
