class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: {  greater_than_or_equal_to: 0, allow_nil: true }

  has_many_attached :images
end
