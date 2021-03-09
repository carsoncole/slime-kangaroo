json.extract! admin_promotion, :id, :code, :name, :discount_percentage, :start, :end, :created_at, :updated_at
json.url admin_promotion_url(admin_promotion, format: :json)
