json.extract! product, :id, :name, :description, :product_id, :price, :created_at, :updated_at
json.url product_url(product, format: :json)
