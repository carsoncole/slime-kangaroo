json.extract! promotion, :id, :code, :name, :discount_percentage, :start, :end, :created_at, :updated_at
json.url promotion_url(promotion, format: :json)
